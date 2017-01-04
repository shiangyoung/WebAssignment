using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Logic;
using Testing.Models;

namespace Testing
{
    public partial class ProductCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (ShoppingCart shoppingCart = new ShoppingCart())
            {
                decimal cartTotal = 0;
                cartTotal = shoppingCart.GetTotal();
                if (cartTotal > 0)
                {
                    // Display Total.
                    lblTotal.Text = String.Format("{0:c}", cartTotal);
                }
                else
                {
                    LabelTotalText.Text = "";
                    lblTotal.Text = "";
                    ShoppingCartTitle.InnerText = "Shopping Cart is Empty";
                    btnUpdate.Visible = false;
                    btnPayment.Visible = false;
                   

                }
            }

        }
        public List<CARTITEM> GetShoppingCartItems()
        {
            ShoppingCart  shoppingCart = new ShoppingCart();
            return shoppingCart.GetCartItems();
        }

        public List<CARTITEM> UpdateCartItems()
        {
            using (ShoppingCart shoppingCart = new ShoppingCart())
            {
                int cartId = shoppingCart.getCartId();

                ShoppingCart.ShoppingCartUpdates[] cartUpdates = new ShoppingCart.ShoppingCartUpdates[CartList.Rows.Count];
                for (int i = 0; i < CartList.Rows.Count; i++)
                {
                    //This is to store the new values from the entered value in the grid view
                    IOrderedDictionary rowValues = new OrderedDictionary();
                    rowValues = GetValues(CartList.Rows[i]);
                    cartUpdates[i].ProductId = Convert.ToInt32(rowValues["ProductID"]);

                    CheckBox cbRemove = new CheckBox();
                    cbRemove = (CheckBox)CartList.Rows[i].FindControl("Remove");
                    cartUpdates[i].RemoveItem = cbRemove.Checked;

                    TextBox quantityTextBox = new TextBox();
                    quantityTextBox = (TextBox)CartList.Rows[i].FindControl("PurchaseQuantity");
                    cartUpdates[i].PurchaseQuantity = Convert.ToInt16(quantityTextBox.Text.ToString());
                }
                shoppingCart.UpdateShoppingCartDatabase(cartId, cartUpdates);
                CartList.DataBind();
                lblTotal.Text = String.Format("{0:c}", shoppingCart.GetTotal());
                return shoppingCart.GetCartItems();
            }
        }

        public static IOrderedDictionary GetValues(GridViewRow row)
        {
            IOrderedDictionary values = new OrderedDictionary();
            foreach (DataControlFieldCell cell in row.Cells)
            {
                if (cell.Visible)
                {
                    // Extract values from the cell.
                    cell.ContainingField.ExtractValuesFromCell(values, cell, row.RowState, true);
                }
            }
            return values;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            UpdateCartItems();
        }

        protected void btnPayment_Click(object sender, EventArgs e)
        {
            
            GalleryEntities1 _db = new GalleryEntities1();
            ShoppingCart cs = new ShoppingCart();
            List<CARTITEM> orderItem = cs.GetCartItems();
            Guid currentId = (Guid)Membership.GetUser().ProviderUserKey;

            ORDER order = new ORDER
            {
                date = DateTime.Now,
                discount = 0,
                UserId = currentId,
               
                status = "pending"
            };
            _db.ORDERs.Add(order);
            _db.SaveChanges();

            
                for (int i = 0; i < orderItem.Count(); i++)
                {
                    ORDERDETAIL orderDetail = new ORDERDETAIL();
                    orderDetail.ProductId = orderItem[i].ProductId;
                    orderDetail.OrderId = order.OrderId;
                    orderDetail.Quantity = orderItem[i].Quantity;
                    orderDetail.TotalPrice = orderItem[i].TotalPrice;

                    _db.ORDERDETAILs.Add(orderDetail);
                    _db.SaveChanges();
                }
            Session["total"] = cs.GetTotal().ToString();
            Session["orderid"] = order.OrderId.ToString();
            Response.Redirect("~/Payment.aspx");
        }

    }
}
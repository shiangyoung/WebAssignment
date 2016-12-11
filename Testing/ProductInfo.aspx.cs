using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Models;
using Testing.Logic;

namespace Testing
{
    public partial class ProductInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                successAdd.Style["display"] = "none";
                failedAdd.Style["display"] = "none";
            }
        }

        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int ProductId = int.Parse(Request.QueryString["ProductId"]);
            using (ShoppingCart shoppingCart = new ShoppingCart())
            {
                shoppingCart.AddToCart(ProductId);
            }

        protected void btnWishlist_Click(object sender, EventArgs e)
        {
            GalleryEntities1 _db = new GalleryEntities1();
            int productID = Convert.ToInt32(Request.QueryString["ProductID"]);
            int customerID = 4001;

            var existingItem = from w in _db.WISHLISTs
                               where w.ProductId == productID && w.CustomerId == customerID
                               select w;

            if (existingItem.Any())
            {
                successAdd.Style["display"] = "none";
                failedAdd.Style["display"] = "block";
                System.Diagnostics.Debug.WriteLine("exist");
            }
            else
            {
                WISHLIST item = new WISHLIST();
                item.ProductId = productID;
                item.CustomerId = customerID;

                if (ModelState.IsValid)
                {
                    // Save changes here

                    _db.WISHLISTs.Add(item);
                    _db.SaveChanges();

                    successAdd.Style["display"] = "block";
                    failedAdd.Style["display"] = "none";
                }
                System.Diagnostics.Debug.WriteLine("not exist");
                
            }


        }

    }
}
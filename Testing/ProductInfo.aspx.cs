using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Models;
using Testing.Logic;
using System.Web.Security;
using AjaxControlToolkit;

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

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int ProductId = int.Parse(Request.QueryString["ProductId"]);
            using (ShoppingCart shoppingCart = new ShoppingCart())
            {
                shoppingCart.AddToCart(ProductId);
            }
        }

        protected void btnWishlist_Click(object sender, EventArgs e)
        {
            bool loginStatus = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;

            if (loginStatus) { 
            GalleryEntities1 _db = new GalleryEntities1();
            int productID = Convert.ToInt32(Request.QueryString["ProductID"]);
            Guid userId = (Guid)Membership.GetUser().ProviderUserKey;

            var existingItem = from w in _db.WISHLISTs
                               where w.ProductId == productID && w.UserId == userId
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
                item.UserId = userId;

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
            else
            {
                MasterPage masterPage = this.Master as MasterPage;
                ModalPopupExtender ModalPopupExtender1 = (ModalPopupExtender)masterPage.FindControl("ModalPopupExtender1");
                ModalPopupExtender1.Show();
            }


        }

    }
}
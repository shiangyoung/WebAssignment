using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Logic;
using Testing.Models;

namespace Testing
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        public string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                MembershipUser u = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                String name = u.UserName;
                Guid id = (Guid)u.ProviderUserKey;
                int cartId = 123;
                using (GalleryEntities1 db = new GalleryEntities1())
                {
                    cartId = (from c in db.CARTs where c.UserId == id select c.CartId).First();
                }

                HttpContext.Current.Session["cartId"] = cartId;
                PanelLogin.Style.Add("display", "none");
                btnLogin.Visible = false;
                btnRegister.Visible = false;
                btnLogout.Visible = true;
            }

            bool loginStatus = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;

            if (loginStatus)
            {
                li_myaccount.Style["display"] = "block";
            }
            else
            {
                li_myaccount.Style["display"] = "none";
                li_myartwork.Style["display"] = "none";
            }

            if (!Page.User.IsInRole("Artists"))
            {
                li_sales.Visible = false;
                li_myartwork.Visible = false;
            }
                    
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            using (ShoppingCart shoppingCart = new ShoppingCart())
            {
                string cartStr = string.Format("Cart ({0})", shoppingCart.GetCount());
                cartCount.Text = cartStr;
            }
        }
        protected void btnRegister_Click(object sender,EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("~/Registration.aspx");
        }

      
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            HttpContext.Current.Session.Clear(); 


            Response.Redirect("~/ViewGallery.aspx");
        }
    
    }
}
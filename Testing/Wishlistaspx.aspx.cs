using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Models;
using Testing.Logic;

namespace Testing
{
    public partial class Wishlistaspx : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void imgbtnGallery_Click(object sender, ImageClickEventArgs e)
        {
            //Get the reference of the clicked button.
            ImageButton button = (sender as ImageButton);

            //Get the command argument
            string commandArgument = button.CommandArgument;

            Response.Redirect("~/ProductInfo.aspx?ProductId=" + commandArgument);

            
        }

        protected void DeleteButton_Click(object sender, ImageClickEventArgs e)
        {
            //Get the reference of the clicked button.
            ImageButton button = (sender as ImageButton);

            //Get the command argument
            string commandArgument = button.CommandArgument;

            int wishlistid = int.Parse(commandArgument);

            GalleryEntities1 db = new GalleryEntities1();
            var item = new WISHLIST { WishlistId = wishlistid };
            db.Entry(item).State = EntityState.Deleted;
            try
            {
                db.SaveChanges();
                
            }
            catch (DbUpdateConcurrencyException)
            {
                ModelState.AddModelError("",
                  String.Format("Item with id {0} no longer exists in the database.", wishlistid));
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            //Get the reference of the clicked button.
            Button button = (sender as Button);

            //Get the command argument
            string[] commandArgument = button.CommandArgument.ToString().Split(';');

            int wishlistId = Convert.ToInt32(commandArgument[0]);
            int productId = Convert.ToInt32(commandArgument[1]);

            //System.Diagnostics.Debug.WriteLine(wishlistId + "," + productId);
            ShoppingCart sc = new ShoppingCart();
            sc.AddToCart(productId);

            GalleryEntities1 db = new GalleryEntities1();
            var item = new WISHLIST { WishlistId = wishlistId };
            db.Entry(item).State = EntityState.Deleted;
            try
            {
                db.SaveChanges();
                Response.Redirect("~/Wishlistaspx.aspx");

            }
            catch (DbUpdateConcurrencyException)
            {
                ModelState.AddModelError("",
                  String.Format("Item with id {0} no longer exists in the database.", wishlistId));
            }
            
        }
    }
}
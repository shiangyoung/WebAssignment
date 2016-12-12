using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Models;

namespace Testing
{
    public partial class AddProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            Image productImage = (Image)fvAddProduct.FindControl("productImage");
            TextBox fvtxtName = (TextBox)fvAddProduct.FindControl("txtName");
            TextBox fvtxtModel = (TextBox)fvAddProduct.FindControl("txtModel");
            TextBox fvtxtStock = (TextBox)fvAddProduct.FindControl("txtStock");
            TextBox fvtxtPrice = (TextBox)fvAddProduct.FindControl("txtPrice");
            TextBox fvtxtCategory = (TextBox)fvAddProduct.FindControl("txtCategory");
            Button btnConfirm = (Button)fvAddProduct.FindControl("btnConfirm");
            HiddenField hdfCategory = (HiddenField)fvAddProduct.FindControl("hdfCategory");

            if (imageUpload.HasFile){
                string path = Server.MapPath("images/") + imageUpload.PostedFile.FileName;
                imageUpload.SaveAs(path);
                productImage.ImageUrl = "images/" + imageUpload.PostedFile.FileName;
                productImage.Height = new Unit("200px");
                productImage.Width = new Unit("200px");
            }

            fvtxtName.Text =  txtName.Text;
            fvtxtModel.Text = txtModel.Text;
            fvtxtStock.Text = txtPrice.Text;
            fvtxtPrice.Text = txtPrice.Text;

            string categoryText = "";
            foreach(ListItem lstItem in ddlCategory.Items)
            {
                if (lstItem.Selected)
                {
                    categoryText = lstItem.Text;
                }
            }
            fvtxtCategory.Text = categoryText;
            hdfCategory.Value = ddlCategory.SelectedValue;

            btnConfirm.Enabled = true;
        }


        public void fvAddProduct_InsertItem()
        {
            PRODUCT item = new PRODUCT();
            TryUpdateModel(item);

            //Get the username for the currently logged in user
            MembershipUser membershipUser = Membership.GetUser("Username");
            Guid userId = (Guid)membershipUser.ProviderUserKey;
            
            item.ArtistId = userId;
            Image productImage = (Image)fvAddProduct.FindControl("productImage");
            byte[] imgData = System.IO.File.ReadAllBytes(Server.MapPath(productImage.ImageUrl));
            item.Image = imgData;
            if (ModelState.IsValid)
            {
                // Save changes here
                GalleryEntities _db = new GalleryEntities();
                _db.PRODUCTs.Add(item);
                _db.SaveChanges();
                Response.Redirect("~/ViewGallery.aspx");
            }
        }

        protected void fvAddProduct_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {
            Response.Redirect("~/ViewGallery.aspx");
        }
    }
}
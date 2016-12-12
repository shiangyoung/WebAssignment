using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Models;
using System.Drawing.Imaging;
using System.Drawing;
using System.Web.Security;

namespace Testing
{
    public partial class AddItemaspx : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void fvAddItem_InsertItem()
        {
            var item = new PRODUCT();
            TryUpdateModel(item);

            //Get the username for the currently logged in user
            MembershipUser membershipUser = Membership.GetUser("Username");
            Guid userId = (Guid) membershipUser.ProviderUserKey;


            item.ArtistId = userId;

            //To convert the image to binary
            FileUpload imageUpload = (FileUpload)fvAddItem.FindControl("imageUpload");
            HttpPostedFile postedFile = imageUpload.PostedFile;
            string fileName = Path.GetFileName(postedFile.FileName);
            string fileExtension = Path.GetExtension(fileName);
            int fileSize = postedFile.ContentLength;

            if(fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".bmp" ||
                fileExtension.ToLower() == ".gif" || fileExtension.ToLower() == ".png")
            {
                Stream stream = postedFile.InputStream;
                byte[] bytes = ResizeUploadedImage(stream);
                item.Image = bytes;
            }

            if (ModelState.IsValid)
            {
                // Save changes here
                GalleryEntities1 _db = new GalleryEntities1();
                _db.PRODUCTs.Add(item);
                _db.SaveChanges();
                Response.Redirect("~/ViewGallery.aspx");
            }
        }

        private byte[] ResizeUploadedImage(Stream streamToResize)
        {
            byte[] resizedImage;
            using (System.Drawing.Image orginalImage = System.Drawing.Image.FromStream(streamToResize))
            {
                ImageFormat orginalImageFormat = orginalImage.RawFormat;
                int orginalImageWidth = orginalImage.Width;
                int orginalImageHeight = orginalImage.Height;
                int resizedImageWidth = 500; // Type here the width you want
                int resizedImageHeight = Convert.ToInt32(resizedImageWidth * orginalImageHeight / orginalImageWidth);
                using (Bitmap bitmapResized = new Bitmap(orginalImage, resizedImageWidth, resizedImageHeight))
                {
                    using (MemoryStream streamResized = new MemoryStream())
                    {
                        bitmapResized.Save(streamResized, orginalImageFormat);
                        resizedImage = streamResized.ToArray();
                    }
                }
            }

            return resizedImage;
        }
    }
}
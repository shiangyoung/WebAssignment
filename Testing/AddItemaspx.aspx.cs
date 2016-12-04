using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Models;

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
            item.ArtistId = 1001;
            item.CategoryId = 3001;
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
                BinaryReader binaryReader = new BinaryReader(stream);
                byte[] bytes = binaryReader.ReadBytes((int)stream.Length);
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
    }
}
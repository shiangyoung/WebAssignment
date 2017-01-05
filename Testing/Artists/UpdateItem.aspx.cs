using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Models;

namespace Testing
{
    public partial class UpdateItem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void fvAddItem_UpdateItem([QueryString] int ProductId)
        {
            Testing.Models.PRODUCT item = null;

            GalleryEntities1 _db = new GalleryEntities1();
            item = _db.PRODUCTs.Find(ProductId);
            // Load the item here, e.g. item = MyDataLayer.Find(id);
            if (item == null)
            {
                // The item wasn't found
                ModelState.AddModelError("", String.Format("Item with id {0} was not found", ProductId));
                return;
            }

            TryUpdateModel(item);


            //To convert the image to binary
            FileUpload imageUpload = (FileUpload)fvAddItem.FindControl("imageUpload");
            HttpPostedFile postedFile = imageUpload.PostedFile;
            string fileName = Path.GetFileName(postedFile.FileName);
            string fileExtension = Path.GetExtension(fileName);
            int fileSize = postedFile.ContentLength;

            if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".bmp" ||
                fileExtension.ToLower() == ".gif" || fileExtension.ToLower() == ".png")
            {
                Stream stream = postedFile.InputStream;
                BinaryReader binaryReader = new BinaryReader(stream);
                byte[] bytes = binaryReader.ReadBytes((int)stream.Length);
                item.Image = bytes;
            }

            if (ModelState.IsValid)
            {
                // Save changes here, e.g. MyDataLayer.SaveChanges();
                _db.SaveChanges();
                Response.Redirect("~/UpdateGallery.aspx");
            }
        }

        // The id parameter should match the DataKeyNames value set on the control
        // or be decorated with a value provider attribute, e.g. [QueryString]int id
        
        public Testing.Models.PRODUCT fvAddItem_GetItem([QueryString] int ProductId)
        {
            Testing.Models.GalleryEntities1 _db = new Testing.Models.GalleryEntities1();
            return _db.PRODUCTs.Find(ProductId);
            
        }



     
    }
}
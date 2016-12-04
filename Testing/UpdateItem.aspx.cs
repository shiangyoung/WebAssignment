using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Testing
{
    public partial class UpdateItem1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_click(Object sender, EventArgs e)
        {




        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void fvProduct_UpdateItem(int ProductId)
        {
            Testing.Models.PRODUCT item = null;
            // Load the item here, e.g. item = MyDataLayer.Find(id);
            
            Testing.Models.GalleryEntities1 _db = new Testing.Models.GalleryEntities1();
            item = _db.PRODUCTs.Find(ProductId);
            

            if (item == null)
            {
                // The item wasn't found
                ModelState.AddModelError("", String.Format("Item with id {0} was not found", ProductId));
                return;
            }
            TryUpdateModel(item);
            if (ModelState.IsValid)
            {
                // Save changes here, e.g. MyDataLayer.SaveChanges();
                _db.SaveChanges();
                Response.Redirect("~/UpdateItemGallery.aspx");

            }
        }
    }
}
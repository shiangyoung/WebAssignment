using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Models;

namespace Testing
{
    public partial class UpdateGallery : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void imgbtnGallery_Click(object sender, ImageClickEventArgs e)
        {
            //Get the reference of the clicked button.
            ImageButton button = (sender as ImageButton);

            //Get the command argument
            string commandArgument = button.CommandArgument;

            //Get the Repeater Item reference
            //RepeaterItem item = button.NamingContainer as RepeaterItem;

            //Get the repeater item index
            //int index = item.ItemIndex;

            Response.Redirect("~/Artists/UpdateItem.aspx?ProductId=" + commandArgument);
            //System.Diagnostics.Debug.WriteLine(button.ToString() + commandArgument + item.ToString() + index.ToString());
        }

        protected void rptProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "product")
            {

            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<String> GetProductName(string pre)
        {
            List<string> allProductName = new List<string>();
            using (GalleryEntities1 db = new GalleryEntities1())
            {
                allProductName = (from a in db.PRODUCTs
                                  where a.Name.Contains(pre)
                                  select a.Name).ToList();
            }
            return allProductName;
        }
    }
}
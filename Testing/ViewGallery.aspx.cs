using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using Testing.Models;
using Testing.Logic;

namespace Testing
{
    public partial class ViewGallery : System.Web.UI.Page
    {
        static String searchText = "";

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            searchText = txtSearch.Text;
            SqlDataSource1.SelectCommand = "SELECT *  FROM [PRODUCT] WHERE Name LIKE '%"+ searchText +"%'";
            SqlDataSource1.DataBind();
            rptProduct.DataBind();
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

            Response.Redirect("~/ProductInfo.aspx?ProductId=" + commandArgument);
            //System.Diagnostics.Debug.WriteLine(button.ToString() + commandArgument + item.ToString() + index.ToString());
        }

        protected void rptProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "product")
            {

            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (sender as Button);
            string commandArgument = btn.CommandArgument;
            int ProductId = int.Parse(commandArgument);
            using (ShoppingCart shoppingCart = new ShoppingCart())
            {
                shoppingCart.AddToCart(ProductId);
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

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

                SqlDataSource1.SelectCommand = "SELECT * FROM PRODUCT CategoryId WHERE CategoryId = '" + ddlCategory.SelectedValue + "' AND Name LIKE '%"+ searchText +"%'";
                SqlDataSource1.DataBind();
                rptProduct.DataBind();
            
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                System.Diagnostics.Debug.WriteLine("product not exist");
            }

        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {

            //Relevance Product
                if (ddlSort.SelectedIndex == 0)
                {
                    SqlDataSource1.SelectCommand = "SELECT *  FROM [PRODUCT] WHERE Name LIKE '%"+  searchText +"%'";
                    SqlDataSource1.DataBind();
                    rptProduct.DataBind();
                }
                else if (ddlSort.SelectedIndex == 1)
                {
                    SqlDataSource1.SelectCommand = "SELECT *  FROM [PRODUCT] WHERE Name LIKE '%" + searchText + "%' ORDER BY Price DESC";
                    SqlDataSource1.DataBind();
                    rptProduct.DataBind();
                }
                else if (ddlSort.SelectedIndex == 2)
                {
                    SqlDataSource1.SelectCommand = "SELECT *  FROM [PRODUCT] WHERE Name LIKE '%" + searchText + "%' ORDER BY Price";
                    SqlDataSource1.DataBind();
                    rptProduct.DataBind();
                }
            
        }
    }
}
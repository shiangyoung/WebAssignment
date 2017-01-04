using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Testing
{
    public partial class OrderDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:startPage(); ", true);

            Guid userId = (Guid)Membership.GetUser().ProviderUserKey;
            String currentId = userId.ToString();
            SqlDataSource1.SelectParameters["UserId"].DefaultValue = currentId;

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

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine(Repeater1.Items.Count);
            if (Repeater1.Items.Count < 1)
            {
                if (e.Item.ItemType == ListItemType.Header)
                {
                    lblNoRecord.Visible = true;
                    Repeater1.Visible = false;
                }
                else
                {
                    lblNoRecord.Visible = false;
                }

            }
            
        }
    }
    
}
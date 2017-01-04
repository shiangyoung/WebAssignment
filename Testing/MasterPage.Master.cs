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

namespace Testing
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        SqlCommand mycommand;
        public string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                PanelLogin.Style.Add("display", "none");
                btnLogin.Visible = false;
                btnRegister.Visible = false;
                btnLogout.Visible = true;
            }


            if (!Page.User.IsInRole("Artists"))
            {
                li_sales.Style["display"] = "none";
            }
            else
            {
                li_sales.Style["display"] = "block";
                li_myartwork.Style["display"] = "block";
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

        //    protected void CreateUserWizard1_CreatedUser(Object sender, EventArgs e)
        //    {



        //        using (SqlConnection myConnection = new SqlConnection(connectionString))
        //        {

        //            RadioButtonList rblType = (RadioButtonList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("rblType");
        //            if (rblType.SelectedValue == "Member")
        //            {
        //                CreateNewMember();
        //            }
        //            else
        //            {
        //                CreateNewArtist();
        //            }
        //        }
        //    }
        //    protected void updateDropDownList(Object sender, EventArgs e)
        //    {
        //        DropDownList Month = (DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Month");
        //        DropDownList Day = (DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Day");
        //        Day.Items.Clear();
        //        int value = Convert.ToInt32(Month.SelectedValue);
        //        if (value == 2)
        //        {
        //            for (int i = 1; i <= 29; i++)
        //            {
        //                ListItem item = new ListItem(i + "", i + "");
        //                Day.Items.Add(item);
        //            }
        //        }
        //        else if (value == 1 || value == 3 || value == 5 || value == 7 || value == 8 || value == 10 || value == 12)
        //        {
        //            for (int i = 1; i <= 31; i++)
        //            {
        //                ListItem item = new ListItem(i + "", i + "");
        //                Day.Items.Add(item);
        //            }
        //        }
        //        else
        //        {
        //            for (int i = 1; i <= 30; i++)
        //            {
        //                ListItem item = new ListItem(i + "", i + "");
        //                Day.Items.Add(item);
        //            }
        //        }
        //    }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("~/ViewGallery.aspx");
        }
        //    private void CreateNewMember()
        //    {
        //        MembershipUser newUser = Membership.GetUser(CreateUserWizard1.UserName);
        //        Guid newUserId = (Guid)newUser.ProviderUserKey;
        //        string Name = ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Name")).Text;
        //        string Address = ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Address")).Text;
        //        DropDownList ddlYear = (DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Year");
        //        DropDownList ddlMonth = (DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Month");
        //        DropDownList ddlDay = (DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Day");
        //        Int32 day = Int32.Parse(ddlDay.SelectedValue);
        //        Int32 month = Int32.Parse(ddlMonth.SelectedValue);
        //        Int32 year = Int32.Parse(ddlYear.SelectedValue);
        //        DateTime DOB = new DateTime(year, month, day);
        //        using (SqlConnection myConnection = new SqlConnection(connectionString))
        //        {
        //            mycommand = new SqlCommand("new_user", myConnection);
        //            mycommand.CommandType = System.Data.CommandType.StoredProcedure;
        //            mycommand.Parameters.Add("Name", SqlDbType.VarChar).Value = Name;
        //            mycommand.Parameters.Add("Address", SqlDbType.VarChar).Value = Address;
        //            mycommand.Parameters.Add("DateOfBirth", SqlDbType.Date).Value = DOB.Date;
        //            mycommand.Parameters.Add("userId", SqlDbType.UniqueIdentifier).Value = newUserId;
        //            myConnection.Open();
        //            mycommand.ExecuteNonQuery();
        //            myConnection.Close();
        //        }
        //    }
        //    private void CreateNewArtist()
        //    {
        //        MembershipUser newUser = Membership.GetUser(CreateUserWizard1.UserName);
        //        Guid newUserId = (Guid)newUser.ProviderUserKey;
        //        using (SqlConnection myConnection = new SqlConnection(connectionString))
        //        {
        //            mycommand = new SqlCommand("new_artist", myConnection);
        //            mycommand.CommandType = System.Data.CommandType.StoredProcedure;
        //            mycommand.Parameters.Add("userId", SqlDbType.UniqueIdentifier).Value = newUserId;
        //            myConnection.Open();
        //            mycommand.ExecuteNonQuery();
        //            myConnection.Close();
        //        }
        //    }
        //}
    }
}
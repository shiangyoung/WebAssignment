using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;
using System.Web.Profile;
using System.Data.SqlClient;
using System.Data;

namespace Testing
{
    public partial class Registration : System.Web.UI.Page
    {
        public string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            DropDownList Year = (DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Year");
            for (int i = 2003; i >= 1950; i--)
            {
                ListItem item = new ListItem(i + "", i + "");
                Year.Items.Add(item);
            }
            if (IsPostBack)
            {
                DropDownList Month =(DropDownList) CreateUserWizardStep1.ContentTemplateContainer.FindControl("Month");
                DropDownList Day = (DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Day");
                Day.Items.Clear();
                int value = Convert.ToInt32(Month.SelectedValue);
                if (value == 2)
                {
                    for (int i = 1; i <= 29; i++)
                    {
                        ListItem item = new ListItem(i + "", i + "");
                        Day.Items.Add(item);
                    }
                } else if (value == 1 || value == 3 || value == 5 || value == 7 || value == 8 || value == 10 || value == 12) 
                {
                    for (int i = 1; i <= 31; i++)
                    {
                        ListItem item = new ListItem(i + "", i + "");
                        Day.Items.Add(item);
                    }
                }else{
                    for (int i = 1; i <= 30; i++)
                    {
                        ListItem item = new ListItem(i + "", i + "");
                        Day.Items.Add(item);
                    }
                }
            }
        }
        protected void CreateUserWizard1_CreatedUser(Object sender, EventArgs e)
        {
            
            
            MembershipUser newUser = Membership.GetUser(CreateUserWizard1.UserName);
            Guid newUserId = (Guid)newUser.ProviderUserKey;
            string Name = ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Name")).Text;
            string Address = ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Address")).Text;
            DropDownList ddlYear = (DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Year");
            DropDownList ddlMonth = (DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Month");
            DropDownList ddlDay = (DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Day");
            Int32 day = Int32.Parse(ddlDay.SelectedValue);
            Int32 month = Int32.Parse(ddlMonth.SelectedValue);
            Int32 year = Int32.Parse(ddlYear.SelectedValue);
            DateTime DOB = new DateTime(year, month, day);
            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                SqlCommand mycommand = new SqlCommand("new_user", myConnection);
                mycommand.CommandType = System.Data.CommandType.StoredProcedure;
                mycommand.Parameters.Add("Name", SqlDbType.VarChar).Value = Name;
                mycommand.Parameters.Add("Address", SqlDbType.VarChar).Value = Address;
                mycommand.Parameters.Add("DateOfBirth", SqlDbType.Date).Value = DOB.Date;
                mycommand.Parameters.Add("userId", SqlDbType.UniqueIdentifier).Value = newUserId;
                myConnection.Open();
                mycommand.ExecuteNonQuery();
                myConnection.Close();
                
            }
        }
    }
}
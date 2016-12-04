using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
namespace Testing
{
    public partial class RegistrationPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Write(""+calendarBirth.SelectedDate.ToString());
            if (IsPostBack)
            {
                try {
                SqlConnection conn =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                conn.Open();
                String checkUser = "Select count(*) from [USER] where Username='" + tbUserName.Text + "'";
                SqlCommand com = new SqlCommand(checkUser, conn);
                int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
                if (temp == 1)
                {
                    Response.Write("Username already Exists");
                }
                conn.Close();
            }
                catch (Exception Ex)
                {
                    Response.Write("Error: " + Ex.ToString());
                }
            }
        }
        

        protected void btnSend_Click(object sender, EventArgs e)
        {
            SqlConnection conn =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            Guid newGUID = Guid.NewGuid();
            try
            {
                String insertUser = "insert into [User](Username,Password,Name,DateOfBirth,Address,ContactNo,Email) " +
                    "values (@username,@password,@name,@dob,@address,@contact,@email)";
                SqlCommand com = new SqlCommand(insertUser, conn);
                //com.Parameters.AddWithValue("@id", newGUID);
                com.Parameters.AddWithValue("@username", tbUserName.Text);
                com.Parameters.AddWithValue("@password", tbPassword.Text);
                com.Parameters.AddWithValue("@name", tbName.Text);
                com.Parameters.AddWithValue("@dob", calendarBirth.SelectedDate.ToString());
                com.Parameters.AddWithValue("@address", tbAddress.Text);
                com.Parameters.AddWithValue("@contact", tbContact.Text);
                com.Parameters.AddWithValue("@email", tbEmail.Text);
                com.ExecuteNonQuery();
                Response.Write("Registration is successful");
                conn.Close();
            }
            catch (Exception Ex)
            {
                Response.Write("Error: " + Ex.ToString());
            }
        }
    }
}
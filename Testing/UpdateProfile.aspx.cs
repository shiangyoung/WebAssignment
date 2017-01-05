using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Testing.Models;

namespace Testing
{
    public partial class UpdateProfile : System.Web.UI.Page
    {
        MembershipUser u;
        ARTIST artist = null;
        CUSTOMER customer = null;
        System.DateTime date;
        GalleryEntities1 _db;
        protected void Page_Load(object sender, EventArgs e)
        {

            u = Membership.GetUser(User.Identity.Name);
            _db = new Models.GalleryEntities1();

            Guid key = (Guid)u.ProviderUserKey;
            String keyString = key.ToString();
            if (Roles.IsUserInRole("Artists"))
            {
                artist = _db.ARTISTs.Find(key);
            }
            else
            {
                customer = _db.CUSTOMERs.Find(key);
            }
            for (int i = 2003; i >= 1950; i--)
            {
                ListItem item = new ListItem(i + "", i + "");
                ddlYear.Items.Add(item);
            }
            if (!IsPostBack)
            {
                tbEmail.Text = u.Email;

                if (artist != null)
                {
                    tbName.Text = artist.Name;
                    tbAddress.Text = artist.Address;
                    tbContact.Text = artist.ContactNo;
                    date = (DateTime)artist.DateOfBirth;

                }
                else
                {
                    tbName.Text = customer.Name;
                    tbAddress.Text = customer.Address;
                    tbContact.Text = customer.ContactNo;
                    date = (DateTime)customer.DateOfBirth;
                }
                ddlYear.SelectedValue = date.Year.ToString();
                ddlMonth.SelectedValue = date.Month.ToString();
                updateDay();
            }

        }

        protected void updateDropDownList(object sender, EventArgs e)
        {
            updateDay();

        }

        private void updateDay()
        {
            ddlDay.Items.Clear();
            int value = date.Month;
            if (value == 2)
            {
                for (int i = 1; i <= 29; i++)
                {
                    ListItem item = new ListItem(i + "", i + "");
                    ddlDay.Items.Add(item);
                }
            }
            else if (value == 1 || value == 3 || value == 5 || value == 7 || value == 8 || value == 10 || value == 12)
            {
                for (int i = 1; i <= 31; i++)
                {
                    ListItem item = new ListItem(i + "", i + "");
                    ddlDay.Items.Add(item);
                }

            }
            else
            {
                for (int i = 1; i <= 30; i++)
                {
                    ListItem item = new ListItem(i + "", i + "");
                    ddlDay.Items.Add(item);
                }
            }
            ddlDay.SelectedValue = date.Day.ToString();
        }

        protected void tbAddress_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ChangePassword1_ChangedPassword(object sender, EventArgs e)
        {

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            u.Email = tbEmail.Text;

            Membership.UpdateUser(u);
            Int32 day = Int32.Parse(ddlDay.SelectedValue);
            Int32 month = Int32.Parse(ddlMonth.SelectedValue);
            Int32 year = Int32.Parse(ddlYear.SelectedValue);
            Int32 Age = DateTime.Now.Year - year;
            DateTime DOB = new DateTime(year, month, day);
            if (artist != null)
            {
                artist.ContactNo = tbContact.Text;
                artist.Name = tbName.Text;
                artist.Address = tbAddress.Text;
                artist.Age = Age;
                artist.DateOfBirth = DOB;
                TryUpdateModel(artist);
            }
            else
            {
                customer.ContactNo = tbContact.Text;
                customer.Name = tbName.Text;
                customer.Address = tbAddress.Text;
                customer.Age = Age;
                customer.DateOfBirth = DOB;
                _db.CUSTOMERs.Attach(customer);
                _db.Entry(customer).State = System.Data.Entity.EntityState.Modified;
                _db.SaveChanges();
            }
            Response.Redirect("~/UpdateProfile.aspx");
        }

        protected void ContinuePushButton_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            HttpContext.Current.Session.Clear();
            Response.Redirect("~/Login.aspx");
        }
    }
}
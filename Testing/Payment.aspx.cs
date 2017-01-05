using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Models;

namespace Testing
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MembershipUser u;

            u = Membership.GetUser(User.Identity.Name);
            String key = u.ProviderUserKey.ToString();
            GalleryEntities1 _db = new GalleryEntities1();
            CUSTOMER customer = _db.CUSTOMERs.Find(key);
            TextBox address = (TextBox)FormViewPayment.FindControl("txtboxAddress");
            address.Text = customer.Address;
            //address.Text = u.a
            TextBox email = (TextBox) FormViewPayment.FindControl("txtboxEmail");
            email.Text = u.Email;
            email.Enabled = false;
            Session["email"] = email.Text;
            double total1 = Convert.ToDouble(Session["total"]);
            TextBox txtboxTotal = (TextBox)FormViewPayment.FindControl("txtboxTotal");
            txtboxTotal.Text = String.Format("{0:0.00}",total1);
        }

        public void FormViewPayment_InsertItem()
        {   
            String orderid = (String)Session["orderid"];
            int orderidInt = Convert.ToInt32(Session["orderid"]);
            TextBox address = (TextBox)FormViewPayment.FindControl("txtboxAddress");
            Session["address"] = address.Text;



            using (var _db1 = new GalleryEntities1())
            {
                try
                {
                    var myItem = (from c in _db1.ORDERs where c.OrderId == orderidInt select c).FirstOrDefault();
                    if (myItem != null)
                    {
                        myItem.status = "Paid";
                        _db1.SaveChanges();
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Update Order Status - " + exp.Message.ToString(), exp);
                }
               
               
                PAYMENT payment = new PAYMENT();
                TryUpdateModel(payment);
                payment.Date = DateTime.Now;
                payment.OrderId = orderid;
                // Guid userId = (Guid)Membership.GetUser().ProviderUserKey;
                if (ModelState.IsValid)
                {
                    GalleryEntities1 _db = new GalleryEntities1();
                    _db.PAYMENTs.Add(payment);
                    _db.SaveChanges();

                }

                Response.Redirect("~/PaymentSucess.aspx");
            }
        }


        protected void FormViewPayment_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {   
            RadioButtonList rbl = (RadioButtonList) FormViewPayment.FindControl("rblType");
            RegularExpressionValidator regexValid = (RegularExpressionValidator)FormViewPayment.FindControl("RegularExpressionValidator3");
            string x = rbl.Text.ToString();
            if (x == "Visa")
            {
                regexValid.ValidationExpression = @"^4\d{13}$";
            }
            else if (x == "Master")
            {
                regexValid.ValidationExpression = @"^5\d{13}$";
            }


            //if (Page.IsValid)
            //{
            //    lblSummary.Text = Label1.Text + ":" + txtUserName.Text.ToString() + "\n" + Label2.Text + ":" + txtPassword.Text.ToString() + "\n" + Label3.Text + ":" + txtAge.Text.ToString() + "\n" + Label4.Text + ":" + txtDob.Text.ToString() + "\n" + Label6.Text + ":" + txtCreditCard.Text.ToString();
            //}
        }
    }
}
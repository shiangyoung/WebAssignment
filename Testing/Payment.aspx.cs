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

            TextBox address = (TextBox)FormViewPayment.FindControl("txtboxAddress");
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

       
    }
}
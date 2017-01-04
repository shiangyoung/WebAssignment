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
  
            double total1 = Convert.ToDouble(Session["total"]);
            TextBox txtboxTotal = (TextBox)FormViewPayment.FindControl("txtboxTotal");
            txtboxTotal.Text = String.Format("{0:0.00}",total1);
        }

        public void FormViewPayment_InsertItem()
        {
            String orderid = (String)Session["orderid"];
            PAYMENT payment = new PAYMENT();
            TryUpdateModel(payment);
            payment.Date = DateTime.Now;
            payment.OrderId = orderid;
            if (ModelState.IsValid)
            {
                GalleryEntities1 _db = new GalleryEntities1();
                _db.PAYMENTs.Add(payment);
                _db.SaveChanges();

            }

            Response.Redirect("~/PaymentSucess.aspx");
        }


        protected void FormViewPayment_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {

        }

       
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Models;
using System.Data;

using System.IO;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Net.Mail;
using System.Web.Security;
using Testing.Logic;

namespace Testing
{
    public partial class PaymentSucess : System.Web.UI.Page
    {  

        protected void GenerateInvoicePDF(object sender, EventArgs e)
        {   

            string companyName = "Gallery Website";
            string address = Convert.ToString(Session["address"]);
            int orderid = Convert.ToInt32(Session["orderid"]);
            int orderNo = orderid;
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[4] { new DataColumn("ProductId", typeof(int)),
                 new DataColumn("Name", typeof(string)),
             new DataColumn("Quantity",typeof(int)),
             new DataColumn("Total Price",typeof(Double))});

            GalleryEntities1 _db = new GalleryEntities1();
            List<ORDERDETAIL> orderdetails = _db.ORDERDETAILs.Where(
                    c => c.OrderId == orderid).ToList();

            for (int i = 0; i < orderdetails.Count; i++)
            {
                PRODUCT product = _db.PRODUCTs.Find(orderdetails[i].ProductId);

                dt.Rows.Add(orderdetails[i].ProductId, product.Name, orderdetails[i].Quantity, orderdetails[i].TotalPrice);
            }

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringBuilder sb = new StringBuilder();

                    //Generate Invoice (Bill) Header.
                    sb.Append("<table width='100%' cellspacing='0' cellpadding='2'>");
                    sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>Receipt</b></td></tr>");
                    sb.Append("<tr><td colspan = '2'></td></tr>");
                    sb.Append("<tr><td><b>Order No: </b>");
                    sb.Append(orderNo);
                    sb.Append("</td><td align = 'right'><b>Date: </b>");
                    sb.Append(DateTime.Now);
                    sb.Append(" </td></tr>");
                    sb.Append("<tr><td><b>Company Name: </b>");
                    sb.Append(companyName);
                    sb.Append("</td><td align = 'right'><b>Address: </b>");
                    sb.Append(address);
                    sb.Append("</td></tr>");
                    sb.Append("</table>");
                    sb.Append("<br />");

                    //Generate Invoice (Bill) Items Grid.
                    sb.Append("<table border = '1'>");
                    sb.Append("<tr>");
                    foreach (DataColumn column in dt.Columns)
                    {
                        sb.Append("<th>");
                        sb.Append(column.ColumnName);
                        sb.Append("</th>");
                    }
                    sb.Append("</tr>");
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<tr>");
                        foreach (DataColumn column in dt.Columns)
                        {
                            sb.Append("<td>");
                            sb.Append(row[column]);
                            sb.Append("</td>");
                        }
                        sb.Append("</tr>");
                    }
                    sb.Append("<tr><td align = 'right' colspan = '");
                    sb.Append(dt.Columns.Count - 1);
                    sb.Append("'>Total</td>");
                    sb.Append("<td>");
                    double total1 = Convert.ToDouble(Session["total"]);
                    sb.Append(String.Format("{0:0.00}", total1));
                    sb.Append("</td>");
                    sb.Append("</tr></table>");

                    //Export HTML String as PDF.
                    StringReader sr = new StringReader(sb.ToString());
                    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    htmlparser.Parse(sr);
                    pdfDoc.Close();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=Invoice_" + orderNo + ".pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();


                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            using (ShoppingCart shoppingCart = new ShoppingCart())
            {
                shoppingCart.EmptyCart();
            }

            int orderid = Convert.ToInt32(Session["orderid"]);
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[4] { new DataColumn("ProductId", typeof(int)),
                 new DataColumn("Name", typeof(string)),
             new DataColumn("Quantity",typeof(int)),
             new DataColumn("TotalPrice",typeof(Double))
            });

            GalleryEntities1 _db = new GalleryEntities1();
            List<ORDERDETAIL> orderdetails = _db.ORDERDETAILs.Where(
                    c => c.OrderId == orderid).ToList();

            for (int i = 0; i < orderdetails.Count; i++)
            {
                PRODUCT product = _db.PRODUCTs.Find(orderdetails[i].ProductId);
                String stockCount = product.Stock;
                int stockCountValue = Convert.ToInt32(stockCount);
                stockCountValue--;
                stockCount = stockCountValue.ToString();
                product.Stock = stockCount;
                _db.SaveChanges();
                dt.Rows.Add(orderdetails[i].ProductId, product.Name, orderdetails[i].Quantity, orderdetails[i].TotalPrice);
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();
            double total1 = Convert.ToDouble(Session["total"]);
            // Label lblTotal = (Label)GridView1.FindControl("lblTotal");
            lblTotal.Text = String.Format("{0:0.00}", total1);
            

            //for receipt email
            string companyName = "Gallery Website";
            string address = Convert.ToString(Session["address"]);
            int orderid1 = Convert.ToInt32(Session["orderid"]);
            int orderNo = orderid1;
            DataTable dt1 = new DataTable();
            dt1.Columns.AddRange(new DataColumn[4] { new DataColumn("ProductId", typeof(int)),
                 new DataColumn("Name", typeof(string)),
             new DataColumn("Quantity",typeof(int)),
             new DataColumn("Total Price",typeof(Double))});

            GalleryEntities1 _db1 = new GalleryEntities1();
            List<ORDERDETAIL> orderdetails1 = _db1.ORDERDETAILs.Where(
                    c => c.OrderId == orderid1).ToList();

            for (int i = 0; i < orderdetails1.Count; i++)
            {
                PRODUCT product = _db1.PRODUCTs.Find(orderdetails1[i].ProductId);

                dt1.Rows.Add(orderdetails1[i].ProductId, product.Name, orderdetails1[i].Quantity, orderdetails1[i].TotalPrice);
            }

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringBuilder sb = new StringBuilder();

                    //Generate Invoice/Receipt Header.
                    sb.Append("<table width='100%' cellspacing='0' cellpadding='2'>");
                    sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>Receipt</b></td></tr>");
                    sb.Append("<tr><td colspan = '2'></td></tr>");
                    sb.Append("<tr><td><b>Order No: </b>");
                    sb.Append(orderNo);
                    sb.Append("</td><td align = 'right'><b>Date: </b>");
                    sb.Append(DateTime.Now);
                    sb.Append(" </td></tr>");
                    sb.Append("<tr><td><b>Company Name: </b>");
                    sb.Append(companyName);
                    sb.Append("</td><td align = 'right'><b>Address: </b>");
                    sb.Append(address);
                    sb.Append("</td></tr>");
                    sb.Append("</table>");
                    sb.Append("<br />");

                    //Generate Invoice (Bill) Items Grid.
                    sb.Append("<table border = '1'>");
                    sb.Append("<tr>");
                    foreach (DataColumn column in dt1.Columns)
                    {
                        sb.Append("<th>");
                        sb.Append(column.ColumnName);
                        sb.Append("</th>");
                    }
                    sb.Append("</tr>");
                    foreach (DataRow row in dt1.Rows)
                    {
                        sb.Append("<tr>");
                        foreach (DataColumn column in dt1.Columns)
                        {
                            sb.Append("<td>");
                            sb.Append(row[column]);
                            sb.Append("</td>");
                        }
                        sb.Append("</tr>");
                    }
                    sb.Append("<tr><td align = 'right' colspan = '");
                    sb.Append(dt1.Columns.Count - 1);
                    sb.Append("'>Total</td>");
                    sb.Append("<td>");
                    double total2 = Convert.ToDouble(Session["total"]);
                    sb.Append(String.Format("{0:0.00}", total2));
                    sb.Append("</td>");
                    sb.Append("</tr></table>");

                    //Export HTML String as PDF.
                    StringReader sr = new StringReader(sb.ToString());
                    Document pdfDoc1 = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc1);
                    using (MemoryStream memoryStream = new MemoryStream())
                    {
                        PdfWriter writer = PdfWriter.GetInstance(pdfDoc1, memoryStream);
                        pdfDoc1.Open();
                        htmlparser.Parse(sr);
                        pdfDoc1.Close();
                        byte[] bytes = memoryStream.ToArray();
                        memoryStream.Close();

                        MailMessage mm = new MailMessage("classrepteam@gmail.com", "edwinteo96@gmail.com");
                        mm.Subject = "Receipt PDF";
                        mm.Body = "Receipt PDF Attachment";
                        mm.Attachments.Add(new Attachment(new MemoryStream(bytes), "ReceiptPDF.pdf"));
                        mm.IsBodyHtml = true;
                        SmtpClient smtp = new SmtpClient();
                        smtp.Host = "smtp.gmail.com";
                        smtp.EnableSsl = true;
                        System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();
                        NetworkCred.UserName = "classrepteam@gmail.com";
                        NetworkCred.Password = "classrepteam96";
                        smtp.UseDefaultCredentials = true;
                        smtp.Credentials = NetworkCred;
                        smtp.Port = 587;
                        smtp.Send(mm);

                    }
                }
            }
        }

                

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            GenerateInvoicePDF(sender, e);
        }

    }

}
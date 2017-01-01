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

namespace Testing
{
    public partial class PaymentSucess : System.Web.UI.Page
    {
        protected void GenerateInvoicePDF(object sender, EventArgs e)
        {
            //Dummy data for Invoice (Bill).
            string companyName = "Gallery Website";
            string address = "No36, jalan ara sd7/3e Bandar Sri Damansara";
            int orderid = Convert.ToInt32(Session["orderid"]);
            int orderNo = orderid;
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[4] { new DataColumn("ProductId", typeof(int)),
                 new DataColumn("Name", typeof(string)),
             new DataColumn("Quantity",typeof(int)),
             new DataColumn("TotalPrice",typeof(Double))});

            GalleryEntities1 _db = new GalleryEntities1();
            List<ORDERDETAIL> orderdetails = _db.ORDERDETAILs.Where(
                    c => c.OrderId == orderid).ToList();

            for (int i = 0; i < orderdetails.Count; i++)
            {
                PRODUCT product = _db.PRODUCTs.Find(orderdetails[i].ProductId);

                dt.Rows.Add(orderdetails[i].ProductId, product.Name, orderdetails[i].Quantity, orderdetails[i].TotalPrice);
            }

            //dt.Rows.Add(101, "Sun Glasses", 200, 5, 1000);
            //dt.Rows.Add(102, "Jeans", 400, 2, 800);
            //dt.Rows.Add(103, "Trousers", 300, 3, 900);
            //dt.Rows.Add(104, "Shirts", 550, 2, 1100);

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

                dt.Rows.Add(orderdetails[i].ProductId, product.Name, orderdetails[i].Quantity, orderdetails[i].TotalPrice);
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();
            double total1 = Convert.ToDouble(Session["total"]);
            // Label lblTotal = (Label)GridView1.FindControl("lblTotal");
            lblTotal.Text = String.Format("{0:0.00}", total1);
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            GenerateInvoicePDF(sender, e);
        }



        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        //public IQueryable gdOrderItem_GetData()
        //{
        //   // String orderid = (String)Session["orderid"];
        //    int orderid = Convert.ToInt32(Session["orderid"]);
        //    GalleryEntities1 _db = new GalleryEntities1();

        //    return _db.ORDERDETAILs.Where(
        //        c => c.OrderId == orderid);



        //}
    }

}
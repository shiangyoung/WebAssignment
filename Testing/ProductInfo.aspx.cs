using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Logic;

namespace Testing
{
    public partial class ProductInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int ProductId = int.Parse(Request.QueryString["ProductId"]);
            using (ShoppingCart shoppingCart = new ShoppingCart())
            {
                shoppingCart.AddToCart(ProductId);
            }

        }
    }
}
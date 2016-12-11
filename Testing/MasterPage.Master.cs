using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Testing.Logic;

namespace Testing
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            using (ShoppingCart shoppingCart = new ShoppingCart())
            {
                string cartStr = string.Format("Cart ({0})", shoppingCart.GetCount());
                cartCount.Text = cartStr;
            }
        }
    }
}
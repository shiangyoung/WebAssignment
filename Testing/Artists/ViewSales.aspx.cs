using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Testing
{
    public partial class ViewSales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Guid userId = (Guid)Membership.GetUser().ProviderUserKey;
            String artistId = userId.ToString();
            SqlDataSource1.SelectParameters["ArtistId"].DefaultValue = artistId;



        }
    }
}
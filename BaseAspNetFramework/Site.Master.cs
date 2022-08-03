using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BaseAspNetFramework
{
    public partial class SiteMaster : MasterPage
    {

        public string DataHora = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
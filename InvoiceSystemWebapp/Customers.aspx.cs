using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvoiceWebapp
{
    public partial class Customers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        // Updating of table
        protected void CustomersGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int customerID = Convert.ToInt32(CustomersGrid.DataKeys[e.RowIndex]["CustomerID"]);
            string name = CustomersGrid.DataKeys[e.RowIndex]["Name"].ToString();
            string address = CustomersGrid.DataKeys[e.RowIndex]["Address"].ToString();
            string contactInfo = CustomersGrid.DataKeys[e.RowIndex]["ContactInfo"].ToString();
            CustomersSource.UpdateParameters["CustomerID"].DefaultValue = customerID.ToString();
            CustomersSource.UpdateParameters["Name"].DefaultValue = name;
            CustomersSource.UpdateParameters["Address"].DefaultValue = address;
            CustomersSource.UpdateParameters["ContactInfo"].DefaultValue = contactInfo;
        }
        // Handles Deletion
        protected void CustomersGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int customerID = Convert.ToInt32(CustomersGrid.DataKeys[e.RowIndex]["CustomerID"]);
            CustomersSource.DeleteParameters["CustomerID"].DefaultValue = customerID.ToString();
        }

        // Hides or unhides insert panel
        protected void btnAddCustomer_Click(object sender, EventArgs e)
        {
            CustomerInsertPanel.Enabled = !CustomerInsertPanel.Enabled;
            CustomerInsertPanel.Visible = !CustomerInsertPanel.Visible;
        }

        // Does checks then inserts new data entered on insert panel
        protected void AddNewCustomer(object sender, EventArgs e)
        {
            string name;
            string address;
            string contactInfo;
            if(txtCustomerName.Text == "")
            {
                txtCustomerName.Text = "Please Enter a valid Name";
                return;
            }
            if(txtAddress.Text == "")
            {
                txtAddress.Text = "Please Enter a valid Name";
                return;
            }
            if(txtContactInfo.Text == "")
            {
                txtContactInfo.Text = "Please Enter a valid Name";
                return;
            }
            name = txtCustomerName.Text;
            address = txtAddress.Text;
            contactInfo = txtContactInfo.Text;
            CustomersSource.InsertParameters["Name"].DefaultValue = name;
            CustomersSource.InsertParameters["Address"].DefaultValue = address;
            CustomersSource.InsertParameters["ContactInfo"].DefaultValue= contactInfo;
            CustomersSource.Insert();
        }

    }
}
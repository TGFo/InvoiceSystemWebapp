using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvoiceWebapp
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // Handles Updating of gridview and database table
        protected void InvoiceGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            DropDownList ddl = (DropDownList)InvoiceGrid.Rows[e.RowIndex].FindControl("CustomersDropdown");
            Calendar calendar = (Calendar)InvoiceGrid.Rows[e.RowIndex].FindControl("InvoiceDateCalender");
            int invoiceID = Convert.ToInt32(InvoiceGrid.DataKeys[e.RowIndex]["InvoiceID"]);
            if (ddl != null)
            {
                InvoiceDBSource.UpdateParameters["CustomerID"].DefaultValue = ddl.SelectedValue;
            }
            if(calendar != null)
            {
                InvoiceDBSource.UpdateParameters["InvoiceDate"].DefaultValue = calendar.SelectedDate.ToString();
            }
            double totalAmount = Convert.ToDouble(InvoiceGrid.DataKeys[e.RowIndex]["TotalAmount"]);
            InvoiceDBSource.UpdateParameters["InvoiceID"].DefaultValue = invoiceID.ToString();
            InvoiceDBSource.UpdateParameters["TotalAmount"].DefaultValue = totalAmount.ToString();
            ddl.Dispose();
            calendar.Dispose();
        }

        // Handles deletion
        protected void InvoiceGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int invoiceID = Convert.ToInt32(InvoiceGrid.DataKeys[e.RowIndex]["InvoiceID"]);
            InvoiceDBSource.DeleteParameters["InvoiceID"].DefaultValue = invoiceID.ToString();
        }

        // Hides or unhides insert panel when pressed
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            InvoiceInsertPanel.Enabled = !InvoiceInsertPanel.Enabled;
            InvoiceInsertPanel.Visible = !InvoiceInsertPanel.Visible;
        }

        protected void AddNewInvoice(object sender, EventArgs e)
        {
            int customerID = Convert.ToInt32(InsertCustomerDropdown.SelectedValue);
            DateTime invoiceDate = NewInvoiceDateCalender.SelectedDate;
            double totalAmount;
            if (!double.TryParse(txtTotalAmount.Text, out totalAmount))
            {
                txtTotalAmount.Text = "Please enter a valid amount";
                return;
            }
            InvoiceDBSource.InsertParameters["CustomerID"].DefaultValue = customerID.ToString();
            InvoiceDBSource.InsertParameters["InvoiceDate"].DefaultValue = invoiceDate.ToString();
            InvoiceDBSource.InsertParameters["TotalAmount"].DefaultValue = totalAmount.ToString();
            InvoiceDBSource.Insert();
        }
    }
}
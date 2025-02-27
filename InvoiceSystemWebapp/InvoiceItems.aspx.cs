using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvoiceWebapp
{
    public partial class InvoiceItems : System.Web.UI.Page
    {
        int invoiceID;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(IsPostBack)return;

            // Checks if the invoiceID from the Invoices page is not null then checks that it is a valid ID
            if (Request["InvoiceID"] != null)
            {
                if (!int.TryParse(Request.QueryString["InvoiceID"], out int ID))
                {
                    return;
                }
                invoiceID = ID;
                lblInvoiceID.Text = invoiceID.ToString();
            }
        }

        // Does the same as normal page load but assigns the default valie of the select parameter for the SQLDataSource
        protected void InvoiceItemsGrid_Load(object sender, EventArgs e)
        {
            if(IsPostBack)return;
            if (!int.TryParse(Request.QueryString["InvoiceID"], out int ID))
            {
                return;
            }
            invoiceID = ID;
            InvoiceItemDBSource.SelectParameters["InvoiceID"].DefaultValue = invoiceID.ToString();
        }

        // Handles updating 
        protected void InvoiceItemsGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if (!int.TryParse(Request.QueryString["InvoiceID"], out invoiceID))
            {
                return;
            }
            DropDownList ddl = (DropDownList)InvoiceItemsGrid.Rows[e.RowIndex].FindControl("ItemDropdown"); // Finds current dropdown
            int invoiceItemID = Convert.ToInt32(InvoiceItemsGrid.DataKeys[e.RowIndex]["InvoiceItemID"]);
            int ItemID = Convert.ToInt32(InvoiceItemsGrid.DataKeys[e.RowIndex]["ItemID"]);
            int Quantity = Convert.ToInt32(InvoiceItemsGrid.DataKeys[e.RowIndex]["Quantity"]);
            InvoiceItemDBSource.UpdateParameters["InvoiceItemID"].DefaultValue = invoiceItemID.ToString();
            InvoiceItemDBSource.UpdateParameters["InvoiceID"].DefaultValue = invoiceID.ToString();
            if (ddl != null)
            {
                // Changes the ItemID value based on the selected value
                InvoiceItemDBSource.UpdateParameters["ItemID"].DefaultValue = ddl.SelectedValue;
            }
            InvoiceItemDBSource.UpdateParameters["Quantity"].DefaultValue = Quantity.ToString();
            ddl.Dispose();
        }

        // Handles Deletion
        protected void InvoiceItemsGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int invoiceItemID = Convert.ToInt32(InvoiceItemsGrid.DataKeys[e.RowIndex]["InvoiceItemID"]);
            InvoiceItemDBSource.DeleteParameters["InvoiceItemID"].DefaultValue = invoiceItemID.ToString();
        }

        // Hides or unhides insertion panel
        protected void btnInsertItem_Click(object sender, EventArgs e)
        {
            InvoiceItemInsertPanel.Enabled = !InvoiceItemInsertPanel.Enabled;
            InvoiceItemInsertPanel.Visible = !InvoiceItemInsertPanel.Visible;
        }

        // Handles error checking and insertion of new data when the button is pressed
        protected void AddNewInvoiceItem(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["InvoiceID"], out invoiceID))
            {
                return;
            }
            int itemID = Convert.ToInt32(AddItemDropdown.SelectedValue);
            int quantity;
            if (!Int32.TryParse(txtTotalAmount.Text, out quantity))
            {
                txtTotalAmount.Text = "Please enter a valid quantity";
                return;
            }
            InvoiceItemDBSource.InsertParameters["InvoiceID"].DefaultValue = invoiceID.ToString();
            InvoiceItemDBSource.InsertParameters["ItemID"].DefaultValue = itemID.ToString();
            InvoiceItemDBSource.InsertParameters["Quantity"].DefaultValue = quantity.ToString();
            InvoiceItemDBSource.Insert();
        }
    }
}
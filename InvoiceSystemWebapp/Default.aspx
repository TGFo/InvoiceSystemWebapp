<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="InvoiceWebapp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">All Invoices</h1>
        </section>
        <!-- SQLDataSource for Invoices table -->
        <asp:SqlDataSource ID="InvoiceDBSource" runat="server" ConnectionString="<%$ ConnectionStrings:InvoiceDBConnection%>" 
            SelectCommand="spGetAllInvoices" 
            UpdateCommand="spUpdateInvoice" UpdateCommandType="StoredProcedure" 
            DeleteCommand="spDeleteInvoice" DeleteCommandType="StoredProcedure" 
            InsertCommand="spAddInvoice" InsertCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:Parameter Name="InvoiceID" Type="Int32"/>
                <asp:Parameter Name="CustomerID" Type="Int32"/>
                <asp:Parameter Name="InvoiceDate" Type="DateTime" />
                <asp:Parameter Name="TotalAmount" Type="Decimal" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:Parameter Name="InvoiceID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="CustomerID" Type="Int32"/>
                <asp:Parameter Name="InvoiceDate" Type="DateTime" />
                <asp:Parameter Name="TotalAmount" Type="Decimal" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="CustomerSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:InvoiceDBConnection%>"
            SelectCommand="spGetAllCustomers" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>

        <!-- Gridview bound to Invoices table -->
        <asp:GridView id="InvoiceGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
            DataKeyNames="InvoiceID"
            DataSourceID="InvoiceDBSource"
            OnRowUpdating="InvoiceGrid_RowUpdating"
            OnRowDeleting="InvoiceGrid_RowDeleting">
            <Columns>
                <asp:BoundField DataField="InvoiceID" HeaderText="Invoice ID" ReadOnly="true"/>
                <asp:TemplateField HeaderText="Customer IDs">
                    <ItemTemplate>
                        <asp:Label ID="lblCustomer" runat="server" Text='<%# Bind("CustomerID") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <!-- Dropdown displaying customer names for editing convienience -->
                        <asp:DropDownList ID="CustomersDropdown" runat="server"
                            DataSourceID="CustomerSource"
                            DataTextField="Name" DataValueField="CustomerID">
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Invoice Date">
                    <ItemTemplate>
                        <asp:Label ID="lblInvoiceDate" runat="server" Text='<%# Bind("InvoiceDate") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Calendar ID="InvoiceDateCalender" runat="server"
                            Caption="Select a date" SelectionMode="Day" SelectedDate="<%# DateTime.Today %>">
                        </asp:Calendar>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" DataFormatString="{0:C}" />
                <asp:CommandField ShowEditButton="true" ShowCancelButton="true" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" Text="Delete" ForeColor="Red"
                            CommandName="Delete" OnClientClick="return confirm('Warning: Deletion is PERMANENT');" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="InvoiceID" DataNavigateUrlFormatString="~\InvoiceItems.aspx?InvoiceID={0}" text="More Details"/>
            </Columns>
        </asp:GridView>

        <!-- Panel with fields and controls for insertion -->
        <asp:Button ID="btnInsert" runat="server" Text="Insert New Invoice" BorderStyle="Groove" OnClick="btnInsert_Click" />
        <asp:Panel ID="InvoiceInsertPanel" runat="server" CssClass="container" Enabled="false" BackColor="White" Visible="false">
            <asp:Table CssClass="table table-borderless" runat="server">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <label>
                            Customer:
                        </label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="InsertCustomerDropdown" runat="server"
                            DataSourceID="CustomerSource"
                            DataTextField="Name"
                            DataValueField="CustomerID">
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <label>
                            Invoice Date:
                        </label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Calendar ID="NewInvoiceDateCalender" runat="server"
                            Caption="Select a date"
                            SelectionMode="Day"
                            SelectedDate="<%# DateTime.Today %>">
                        </asp:Calendar>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <label>
                            Total Amount:
                        </label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtTotalAmount" runat="server" ToolTip="Enter the total cost"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:Button ID="btnInsertInvoice" runat="server" Text="Add New Invoice" OnClick="AddNewInvoice"/>
        </asp:Panel>
    </main>

</asp:Content>

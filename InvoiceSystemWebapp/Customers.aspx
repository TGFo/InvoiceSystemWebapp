<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="InvoiceWebapp.Customers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="row" aria-labelledby="Customers">
        <h1 ID="CustomersHeading">
            Customers & Contacts
        </h1>

        <!-- SQLDataSource for for customers table -->
        <asp:SqlDataSource ID="CustomersSource" runat="server" ConnectionString="<%$ ConnectionStrings:InvoiceDBConnection%>"
            SelectCommand="spGetAllCustomers" SelectCommandType="StoredProcedure"
            UpdateCommand="spUpdateCustomers" UpdateCommandType="StoredProcedure"
            DeleteCommand="spDeleteCustomer" DeleteCommandType="StoredProcedure"
            InsertCommand="spAddCustomer" InsertCommandType="StoredProcedure">
            <UpdateParameters>
                    <asp:Parameter Name="CustomerID" Type="Int32" />
                    <asp:Parameter Name="Name" />
                    <asp:Parameter Name="Address" />
                    <asp:Parameter Name="ContactInfo" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:Parameter Name="CustomerID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                    <asp:Parameter Name="Name" />
                    <asp:Parameter Name="Address" />
                    <asp:Parameter Name="ContactInfo" />
            </InsertParameters>
        </asp:SqlDataSource>

        <!-- Gridview bound to Customers table -->
        <asp:GridView ID="CustomersGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
            DataSourceID="CustomersSource"
            DataKeyNames="CustomerID"
            OnRowUpdating="CustomersGrid_RowUpdating"
            OnRowDeleting="CustomersGrid_RowDeleting">
            <Columns>
                <asp:BoundField DataField="CustomerID" HeaderText="Customer ID" ReadOnly="true" />
                <asp:BoundField DataField="Name" HeaderText="Customer Name" />
                <asp:BoundField DataField="Address" HeaderText="Customer Address" />
                <asp:BoundField DataField="ContactInfo" HeaderText="Customer Contact Information" />
                <asp:CommandField ShowEditButton="true" ShowCancelButton="true" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" ForeColor="Red"
                            CommandName="Delete" OnClientClick="return confirm('Warning: Deletion is PERMANENT');">
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <!-- Controls and fields for insertion -->
        <asp:Button ID="btnAddCustomer" runat="server" Text="Add Invoice Item" BorderStyle="Groove" OnClick="btnAddCustomer_Click" />
        <asp:Panel ID="CustomerInsertPanel" runat="server" CssClass="container" Enabled="false" BackColor="White" Visible="false">
            <asp:Table CssClass="table table-borderless" runat="server">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <label>
                            Customer's Name:
                        </label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtCustomerName" runat="server" ToolTip="Customer Name"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <label>
                            Customer Address:
                        </label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtAddress" runat="server" ToolTip="Customer Address"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <label>
                            Contact Information:
                        </label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtContactInfo" runat="server" ToolTip="Customer Contact Information"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:Button ID="btnInsertCusomer" runat="server" Text="Add New Item" OnClick="AddNewCustomer"/>
        </asp:Panel>
    </section>
</asp:Content>

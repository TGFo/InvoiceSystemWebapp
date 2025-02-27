<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InvoiceItems.aspx.cs" Inherits="InvoiceWebapp.InvoiceItems" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="row" aria-labelledby="InvoiceItems">
        <h1 id="InvoiceItemPageHeading">
            All items
        </h1>
        <div class="row">
            <asp:Label runat="server">
                Invoice ID:
            </asp:Label>
            <asp:Label ID="lblInvoiceID" runat="server"></asp:Label>
        </div>

        <!-- SQLSources for InvoiceItems and Items -->
        <asp:SqlDataSource ID="InvoiceItemDBSource" runat="server" ConnectionString="<%$ ConnectionStrings:InvoiceDBConnection%>" 
            SelectCommand="spGetInvoiceItems" SelectCommandType="StoredProcedure"
            UpdateCommand="spUpdateInvoiceItem" UpdateCommandType="StoredProcedure" 
            DeleteCommand="spDeleteInvoiceItem" DeleteCommandType="StoredProcedure"
            InsertCommand="spAddInvoiceItem" InsertCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="InvoiceID" Type="Int32"/>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="InvoiceItemID" Type="Int32" />
                <asp:Parameter Name="InvoiceID" Type="Int32"/>
                <asp:Parameter Name="ItemID" Type="Int32"/>
                <asp:Parameter Name="Quantity" Type="Int32" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:Parameter Name="InvoiceItemID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="InvoiceID" Type="Int32"/>
                <asp:Parameter Name="ItemID" Type="Int32"/>
                <asp:Parameter Name="Quantity" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="ItemsSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:InvoiceDBConnection%>"
            SelectCommand="spGetAllItems" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>

        <!-- Gridview bound to database table allowing for easy updating and deletion -->
        <asp:GridView ID="InvoiceItemsGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
            DataKeyNames="InvoiceItemID"
            DataSourceID="InvoiceItemDBSource"
            OnLoad="InvoiceItemsGrid_Load"
            OnRowUpdating="InvoiceItemsGrid_RowUpdating"
            OnRowDeleting="InvoiceItemsGrid_RowDeleting">
            <Columns>
                <asp:BoundField DataField="InvoiceItemID" HeaderText="Invoice Item ID" ReadOnly="true" />
                <asp:TemplateField HeaderText="Item ID">
                    <ItemTemplate>
                        <asp:Label ID="ItemID" Text='<%#Bind("ItemID") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <!-- Dropdown displaying item names for editing convienience -->
                        <asp:DropDownList ID="ItemDropdown" runat="server"
                            DataSourceID="ItemsSource" 
                            DataValueField="ItemID" DataTextField="Name">
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ItemName" HeaderText="Item Name" ReadOnly="true" />
                <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" DataFormatString="{0:C}" ReadOnly="true"/>
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" DataFormatString="{0:C}" ReadOnly="true" />
                <asp:CommandField ShowEditButton="true" ShowCancelButton="true" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" Text="Delete" ForeColor="Red"
                            CommandName="Delete" OnClientClick="return confirm('Warning: Deletion is PERMANENT');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <!-- Panel and fields for adding new invoice items -->
        <asp:Button ID="btnInsertItem" runat="server" Text="Add Invoice Item" BorderStyle="Groove" OnClick="btnInsertItem_Click" />
        <asp:Panel ID="InvoiceItemInsertPanel" runat="server" CssClass="container" Enabled="false" BackColor="White" Visible="false">
            <asp:Table CssClass="table table-borderless" runat="server">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <label>
                            Item:
                        </label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="AddItemDropdown" runat="server"
                            DataSourceID="ItemsSource" 
                            DataValueField="ItemID" DataTextField="Name">
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <label>
                            Item Quantity:
                        </label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtTotalAmount" runat="server" ToolTip="Enter the number of items"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:Button ID="btnInsertInvoiceItem" runat="server" Text="Add New Item" OnClick="AddNewInvoiceItem"/>
        </asp:Panel>
    </section>
</asp:Content>

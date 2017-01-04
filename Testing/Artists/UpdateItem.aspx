<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UpdateItem.aspx.cs" Inherits="Testing.UpdateItem" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        
    <div>
        <asp:FormView ID="fvAddItem" runat="server" DefaultMode="Edit" ItemType="Testing.Models.PRODUCT" InsertMethod="fvAddItem_InsertItem" UpdateMethod="fvAddItem_UpdateItem" SelectMethod="fvAddItem_GetItem">
            <InsertItemTemplate>
                Image : 
                <asp:FileUpload ID="imageUpload" runat="server" />
                <br />
                 Name :
                <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' ></asp:TextBox>
                <br />
                Model :
                <asp:TextBox ID="txtModel" runat="server" Text='<%# Bind("Model") %>' ></asp:TextBox>
                <br />
                Stock :
                <asp:TextBox ID="txtStock" runat="server" Text='<%# Bind("Stock") %>' ></asp:TextBox>
                <br />
                Price :
                <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' ></asp:TextBox>
                <br />
                Category :  
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="CategoryId" SelectedValue='<%# Bind("CategoryId") %>'>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CATEGORY]"></asp:SqlDataSource>
                <br />
                <asp:Button ID="btnInsert" runat="server" Text="Insert" CommandName="Insert" />
            </InsertItemTemplate>
            <EditItemTemplate>
                Image : 
                <asp:FileUpload ID="imageUpload" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="imageUpload" runat="server" Display="Dynamic" Text="*" ErrorMessage="Image not found"></asp:RequiredFieldValidator>
                <br />
                 Name :
                <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtName" runat="server" Display="Dynamic" Text="*" ErrorMessage="Name field cannot be blank"></asp:RequiredFieldValidator>
                <br />
                Model :
                <asp:TextBox ID="txtModel" runat="server" Text='<%# Bind("Model") %>' ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtModel" runat="server" Display="Dynamic" Text="*" ErrorMessage="Model field cannot be blank"></asp:RequiredFieldValidator>
                <br />
                Stock :
                <asp:TextBox ID="txtStock" runat="server" Text='<%# Bind("Stock") %>' ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtStock" runat="server" Display="Dynamic" Text="*" ErrorMessage="Stock field cannot be blank"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtStock" ValidationExpression="^\d+$" ErrorMessage="Stock field must be an integer value" Text="*" Display="Dynamic" EnableClientScript="false"></asp:RegularExpressionValidator>
                <br />
                Price :
                <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtPrice" runat="server" Display="Dynamic" Text="*" ErrorMessage="Price field cannot be blank"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="RegularExpressionValidator" Text="*" Display="Dynamic" EnableClientScript="false" ValidationExpression="^\d+(,\d{1,2})?$"></asp:RegularExpressionValidator>
                <br />
                Category :  
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="CategoryId" SelectedValue='<%# Bind("CategoryId") %>'>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="DropDownList1" runat="server" Display="Dynamic" Text="*" ErrorMessage="Category not selected"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CATEGORY]"></asp:SqlDataSource>
                <br />
                <asp:Button ID="btnEdit" runat="server" Text="Update" CommandName="Update" />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            </EditItemTemplate>
        </asp:FormView>
       
    </div>
    

</asp:Content>

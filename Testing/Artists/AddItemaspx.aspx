<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AddItemaspx.aspx.cs" Inherits="Testing.AddItemaspx" %>

<asp:content id="Content1" contentplaceholderid="ContentPlaceHolder1" runat="server">
    <div>
        <asp:FormView ID="fvAddItem" runat="server" DefaultMode="Insert" ItemType="Testing.Models.PRODUCT" InsertMethod="fvAddItem_InsertItem" OnPageIndexChanging="fvAddItem_PageIndexChanging">
            <InsertItemTemplate>
                Image : 
                <asp:FileUpload ID="imageUpload" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="No image found" Text="*" Display="Dynamic" EnableClientScript="false" ControlToValidate="imageUpload"></asp:RequiredFieldValidator>

                <br />
                 Name :
                <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Name field cannot be blank" Text="*" Display="Dynamic" EnableClientScript="false" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                <br />
                Model :
                <asp:TextBox ID="txtModel" runat="server" Text='<%# Bind("Model") %>' ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Model field cannot be blank" Text="*" Display="Dynamic" EnableClientScript="false" ControlToValidate="txtModel"></asp:RequiredFieldValidator>
                <br />
                Stock :
                <asp:TextBox ID="txtStock" runat="server" Text='<%# Bind("Stock") %>' ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Stock field cannot be blank" Text="*" Display="Dynamic" EnableClientScript="false" ControlToValidate="txtStock"></asp:RequiredFieldValidator>
                <br />
                Price :
                <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Price field cannot be blank" Text="*" Display="Dynamic" EnableClientScript="false" ControlToValidate="txtPrice"></asp:RequiredFieldValidator>
                <br />
                Category :  
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="CategoryId" SelectedValue='<%# Bind("CategoryId") %>'>

                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Category must be selected" Text="*" Display="Dynamic" EnableClientScript="false" ControlToValidate="DropDownList1"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CATEGORY]"></asp:SqlDataSource>
                <br />
                Description : 
                <asp:TextBox ID="txtDescription" runat="server" TextMode="multiline" Columns="50" Rows="5" Text='<%# Bind("Description") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Description field cannot be blank" Text="*" Display="Dynamic" EnableClientScript="false" ControlToValidate="txtDescription" ></asp:RequiredFieldValidator>
                <br />

                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                <asp:Button ID="btnInsert" runat="server" Text="Insert" CommandName="Insert" />
            </InsertItemTemplate>
            </asp:FormView>
            </div>
            </asp:content>

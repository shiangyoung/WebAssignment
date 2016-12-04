<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="Testing.AddProduct" %>

<asp:Content ID="AddProductContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div style="float:left;width:45%;border-right:solid #474747 ;">
        <asp:Label ID="Label1" runat="server" Text="Name : "></asp:Label>
        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
    
        <br />
        <asp:Label ID="Label2" runat="server" Text="Model : "></asp:Label>
        <asp:TextBox ID="txtModel" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Stock:"></asp:Label>
        <asp:TextBox ID="txtStock" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label4" runat="server" Text="Price :"></asp:Label>
        <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Category : "></asp:Label>
        <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="CategoryId" Height="23px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CATEGORY]"></asp:SqlDataSource>
        <br />
        <asp:Label ID="Label6" runat="server" Text="Image :" ></asp:Label>
        <asp:FileUpload ID="imageUpload" runat="server" />
    
        <br />
        <br />

        <div style="text-align:center">
            <asp:Button ID="btnPreview" runat="server" Text="Preview" OnClick="btnUpload_Click" Width="80%" Height="30px" />
        </div>
    </div>
    <div style="width:48.5%;margin:0 auto;float:left;margin-left:25px">
       <asp:FormView ID="fvAddProduct" runat="server" InsertMethod="fvAddProduct_InsertItem" DefaultMode="Insert" ItemType="Testing.Models.PRODUCT" OnPageIndexChanging="fvAddProduct_PageIndexChanging">
            <InsertItemTemplate>
                <div style="float:left">
                    <asp:Image ID="productImage" runat="server" Height="200px" Width="200px"/>
                </div>
                <div style="float:left;margin-left:10px;margin-top:5px">
                    Name :
                    <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' Enabled="False"></asp:TextBox>
                    <br />
                    Model :
                    <asp:TextBox ID="txtModel" runat="server" Text='<%# Bind("Model") %>' Enabled="False"></asp:TextBox>
                    <br />
                    Stock :
                    <asp:TextBox ID="txtStock" runat="server" Text='<%# Bind("Stock") %>' Enabled="False"></asp:TextBox>
                    <br />
                    Price :
                    <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' Enabled="false"></asp:TextBox>
                    <br />
                    Category : 
                    <asp:TextBox ID="txtCategory" runat="server" Enabled="False"></asp:TextBox>
                    <asp:HiddenField ID="hdfCategory" runat="server" Value='<%# Bind("CategoryId") %>'/>
                    <br />
                    <br />
                    <br />
                    <br />
                    <asp:Button ID="btnConfirm" runat="server" Text="Confirm" Height="30px" Width="300px" Enabled="False" CommandName="Insert" />
                </div>
            </InsertItemTemplate>
        </asp:FormView>

    </div>
    
</asp:Content>

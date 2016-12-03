<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ViewGallery.aspx.cs" Inherits="Testing.ViewGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [PRODUCT]"></asp:SqlDataSource>
    
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>&nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
    
    <asp:Panel ID="Panel1" runat="server">
        <div style="width:100%;">
        <asp:Repeater ID="rptProduct" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="rptProduct_ItemCommand">
            <ItemTemplate>
            <div style="display:inline-block" runat="server">
                <div class="galleries" style="margin-top:10px;margin-left:10px">
                    <div style="height:240px;width:240px;text-align:center;vertical-align:central">
                        <asp:ImageButton ID="imgbtnGallery" runat="server" Height="230px" Width="230px" ImageUrl='<%# "data:Image/png;;base64," + Convert.ToBase64String((byte[])Eval("Image")) %>' OnClick="imgbtnGallery_Click" CommandName="product" CommandArgument='<%# Eval("ProductID") %>'/><br />
                    </div>
                    <div style="text-align:center"><asp:Label ID="lblName" runat="server" Text='<%# Eval("Name")%>'></asp:Label></div>
                    <div style="text-align:center"><asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price")%>'></asp:Label></div>
                </div>
            </div>
        </ItemTemplate>
        </asp:Repeater>
        </div>
    </asp:Panel>
    
</asp:Content>

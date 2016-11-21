<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ViewGallery.aspx.cs" Inherits="Testing.ViewGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Gallery]"></asp:SqlDataSource>
    
    <asp:Panel ID="Panel1" runat="server">
        <div style="width:100%">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
            <div style="display:inline-block;" runat="server">
                <div class="galleries" style="margin-top:10px">
                    <asp:ImageButton ID="imgbtnGallery" runat="server" Height="250px" Width="250px" ImageUrl='<%# Eval("Image")%>'/><br />
                    <div style="text-align:center"><asp:Label ID="lblName" runat="server" Text='<%# Eval("Name")%>'></asp:Label></div>
                    <div style="text-align:center"><asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price")%>'></asp:Label></div>
                </div>
            </div>
        </ItemTemplate>
        </asp:Repeater>
        </div>
    </asp:Panel>
    
</asp:Content>

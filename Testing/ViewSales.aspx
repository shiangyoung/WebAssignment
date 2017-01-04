<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ViewSales.aspx.cs" Inherits="Testing.ViewSales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField HeaderText="Product ID" />
            <asp:BoundField HeaderText="Product Name" />
            <asp:BoundField HeaderText="Unit Price" />
            <asp:BoundField HeaderText="Quantity Sold" />
            <asp:BoundField HeaderText="Total Revenue" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT PRODUCT.ProductId, PRODUCT.Name, PRODUCT.Price, COUNT(*) AS TotalQuantity, TotalQuantity * PRODUCT.Price AS TotalPrice FROM [ORDER] INNER JOIN ORDERDETAIL ON [ORDER].OrderId = ORDERDETAIL.OrderId INNER JOIN PRODUCT ON ORDERDETAIL.ProductId = PRODUCT.ProductId INNER JOIN ARTIST ON PRODUCT.ArtistId = ARTIST.ArtistId WHERE (PRODUCT.ArtistId = @ArtistId) GROUP BY ORDERDETAIL.ProductId">
        <SelectParameters>
            <asp:Parameter Name="ArtistId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

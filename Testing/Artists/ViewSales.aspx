<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ViewSales.aspx.cs" Inherits="Testing.ViewSales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="ProductId">
        <Columns>
            <asp:BoundField HeaderText="Product ID" DataField="ProductId" InsertVisible="False" ReadOnly="True" SortExpression="ProductId" />
            <asp:BoundField HeaderText="Product Name" DataField="Name" SortExpression="Name" />
            <asp:BoundField HeaderText="Unit Price" DataField="Price" SortExpression="Price" />
            <asp:BoundField HeaderText="Total Quantity Sold" DataField="TotalQuantity" ReadOnly="True" SortExpression="TotalQuantity" />
            <asp:BoundField HeaderText="Total Revenue" DataField="TotalPrice" ReadOnly="True" SortExpression="TotalPrice" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT PRODUCT.ProductId, PRODUCT.Name, PRODUCT.Price, SUM(ORDERDETAIL.Quantity) AS TotalQuantity, SUM(ORDERDETAIL.Quantity) * PRODUCT.Price AS TotalPrice FROM [ORDER] INNER JOIN ORDERDETAIL ON [ORDER].OrderId = ORDERDETAIL.OrderId INNER JOIN PRODUCT ON ORDERDETAIL.ProductId = PRODUCT.ProductId INNER JOIN ARTIST ON PRODUCT.ArtistId = ARTIST.ArtistId WHERE (PRODUCT.ArtistId = @ArtistId) GROUP BY PRODUCT.ProductId, PRODUCT.Name, PRODUCT.Price">
        <SelectParameters>
            <asp:Parameter Name="ArtistId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

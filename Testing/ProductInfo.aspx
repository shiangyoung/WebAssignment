<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProductInfo.aspx.cs" Inherits="Testing.ProductInfo" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:FormView ID="fvProduct" runat="server" DataKeyNames="ProductId" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div style="float:left">
                <asp:Image ID="imgProduct" runat="server" Height="400px" Width="400px" ImageUrl='<%# "data:Image/png;;base64," + Convert.ToBase64String((byte[])Eval("Image")) %>' />
            </div>
            <div style="float:left;margin-left:20px">
                <asp:Label ID="lblName" runat="server" Font-Size="50px" Text='<%# Eval("Name")%>'></asp:Label>
                <br />
                Price : 
                <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price")%>' Font-Size="20px" ForeColor="ForestGreen"></asp:Label>
                <br />
                Model :
                <asp:Label ID="lblModel" runat="server" Text='<%# Eval("Model")%>'></asp:Label>
                <br />
                Cateory :
                <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("CategoryName")%>'></asp:Label>
                <br />
                Artist
                <asp:Label ID="lblArtistName" runat="server" Text='<%# Eval("ArtistName")%>'></asp:Label>
                <br />
                Artist Contact Number :
                <asp:Label ID="lblContactNo" runat="server" Text='<%# Eval("ContactNo")%>'></asp:Label>
        </ItemTemplate>

    </asp:FormView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT PRODUCT.ProductId, PRODUCT.Name, PRODUCT.Model, PRODUCT.Stock, PRODUCT.Price, PRODUCT.ArtistId, PRODUCT.CategoryId, PRODUCT.Image, ARTIST.Name AS Artistname, ARTIST.ContactNo, CATEGORY.Name AS CategoryName FROM PRODUCT INNER JOIN ARTIST ON PRODUCT.ArtistId = ARTIST.ArtistId INNER JOIN CATEGORY ON PRODUCT.CategoryId = CATEGORY.CategoryId WHERE (PRODUCT.ProductId = @ProductId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProductId" QueryStringField="ProductId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

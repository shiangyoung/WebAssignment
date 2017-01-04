<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Wishlistaspx.aspx.cs" Inherits="Testing.Wishlistaspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:GridView ID="gvWishlist" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="ProductId" Width="100%" HorizontalAlign="Center">
        <RowStyle HorizontalAlign="Center"/>
        <Columns>
            <asp:TemplateField HeaderText="Product">
                <ItemTemplate>
                    <asp:ImageButton ID="imgbtnGallery" runat="server" Height="230px" Width="230px" ImageUrl='<%# "data:Image/png;;base64," + Convert.ToBase64String((byte[])Eval("Image")) %>' OnClick="imgbtnGallery_Click" CommandName="product" CommandArgument='<%# Eval("ProductID") %>' /><br />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
            <asp:BoundField DataField="ArtistName" HeaderText="Artist" SortExpression="Artist" />
            <asp:BoundField DataField="CategoryName" HeaderText="CategoryName" SortExpression="CategoryName" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnAddToCart" runat="server" Text="Add To Cart"  CommandName="AddToCart" CommandArgument='<%#Eval("WishlistId") + ";" +Eval("ProductId")%>' OnClick="btnAddToCart_Click"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                    <asp:HiddenField ID="hdfWishlistId" runat="server" Value='<%#Eval("WishlistId")%>' />
                    <asp:ImageButton ID="DeleteButton" runat="server" ImageUrl="~/Images/rubbish-bin.png" 
                        CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this event?');"
                        AlternateText="Delete" OnClick="DeleteButton_Click" Width="20px" Height="20px" CommandArgument='<%#Eval("WishlistId")%>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>The wishlist is empty</EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT PRODUCT.Name, PRODUCT.Model, PRODUCT.Stock, PRODUCT.Price, PRODUCT.ArtistId, PRODUCT.Image, CATEGORY.Name AS CategoryName, PRODUCT.ProductId, ARTIST.Name AS ArtistName, WISHLIST.WishlistId FROM PRODUCT INNER JOIN WISHLIST ON PRODUCT.ProductId = WISHLIST.ProductId INNER JOIN CATEGORY ON PRODUCT.CategoryId = CATEGORY.CategoryId INNER JOIN ARTIST ON PRODUCT.ArtistId = ARTIST.ArtistId"
        DeleteCommand="DELETE FROM [WISHLIST] WHERE [WishlistId] = @WishlistId">
        <DeleteParameters>
            <asp:Parameter Name="WishlistId" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>

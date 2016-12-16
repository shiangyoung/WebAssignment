<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProductInfo.aspx.cs" Inherits="Testing.ProductInfo" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .btnWishList{
            background-color:transparent;
        }

        .btnWishList:hover{
            color:#E58182;
        }

        .hypWishlist{
            text-decoration:none;
            color:#333;
        }

        .hypWishlist :hover {
            color:white;
        }

    </style>

    <div style="width: 100%">
        <div id="successAdd" runat="server" style="display:none;background-color:green;height: 30px;margin-bottom: 5px;display:none">
            <div style="color: white;float:left;margin-top:5px">Your item has been insert to wishlist</div>
            <div style="float:right;margin-top:5px"><asp:HyperLink ID="hypWishlist" runat="server" CssClass="hypWishlist" NavigateUrl="~/Wishlistaspx.aspx">View My Wishlist</asp:HyperLink></div>
        </div>

        <div id="failedAdd" runat="server" style="display:none;background-color:red;height: 30px;margin-bottom: 5px;display:none">
           <div style="color: white;float:left;margin-top:5px">Your item has been insert to wishlist</div>
            <div style="float:right;margin-top:5px"><asp:HyperLink ID="hypWishlist2" runat="server" CssClass="hypWishlist" NavigateUrl="~/Wishlistaspx.aspx">View My Wishlist</asp:HyperLink></div>
        </div>
        
        <asp:FormView ID="fvProduct" runat="server" DataKeyNames="ProductId" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                <div style="float: left">
                    <asp:Image ID="imgProduct" runat="server" Height="400px" Width="400px" ImageUrl='<%# "data:Image/png;;base64," + Convert.ToBase64String((byte[])Eval("Image")) %>' />
                </div>
                <div style="float: left; margin-left: 20px">
                    <div style="float: right; margin-top: 25px">
                        <asp:Button ID="btnWishlist" runat="server" Text="Add to wishlist"  BorderWidth="0" OnClick="btnWishlist_Click" CssClass="btnWishList"/>
                    </div>
                    <asp:Label ID="lblName" runat="server" Font-Size="50px" Text='<%# Eval("Name")%>'></asp:Label>
                    <div style="clear: both">
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
                <br />
                <div>
                    <asp:Button ID="btnBuyNow" runat="server" Text="Buy Now" Width="300px" Height="40px"/>
                    <asp:Button ID="btnAddToCart" runat="server" Text="Add To Cart" Width="300px" Height="40px" OnClick="btnAddToCart_Click"/>       
                </div>
         </ItemTemplate>
    </asp:FormView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT PRODUCT.ProductId, PRODUCT.Name, PRODUCT.Model, PRODUCT.Description, PRODUCT.Stock, PRODUCT.Price, PRODUCT.Image, CATEGORY.Name AS CategoryName, ARTIST.ContactNo, aspnet_Users.UserName AS ArtistName, PRODUCT.CategoryId FROM CATEGORY INNER JOIN PRODUCT ON CATEGORY.CategoryId = PRODUCT.CategoryId INNER JOIN ARTIST ON PRODUCT.ArtistId = ARTIST.ArtistId INNER JOIN aspnet_Users ON ARTIST.ArtistId = aspnet_Users.UserId WHERE (PRODUCT.ProductId = @ProductId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="ProductId" QueryStringField="ProductId" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    </asp:Content>

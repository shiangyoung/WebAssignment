<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="Testing.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="Panel1" runat="server">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                <div style="width:100%">
                    <div style="background-color: #333; color: white; padding: 5px;width:100%">
                        <div style="float: left; margin-right: 50px; margin-left: 20px">
                            <asp:Label ID="lblOrderNumber" runat="server" Text='<%# "ORDER #" + Eval("OrderId")%>'></asp:Label>
                        </div>
                        <div style="margin-right: 50px; float: left">
                            <asp:Label ID="lblDatePlace" runat="server" Text='<%# "Place on " + Eval("date", "{0:d}")%>'></asp:Label>
                        </div>
                        <div>
                            Total :
                        <asp:Label ID="lblTotal" runat="server" Text='<%# "RM " + String.Format("{0:f2}",Eval("TotalPaid"))%>'></asp:Label>
                        </div>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand='<%# "SELECT ORDERDETAIL.ProductId, ORDERDETAIL.OrderId, ORDERDETAIL.Quantity, ORDERDETAIL.TotalPrice, PRODUCT.Name, PRODUCT.Description, PRODUCT.Model, PRODUCT.Price, PRODUCT.ArtistId, PRODUCT.CategoryId, PRODUCT.Image FROM ORDERDETAIL INNER JOIN PRODUCT ON ORDERDETAIL.ProductId = PRODUCT.ProductId WHERE ORDERDETAIL.OrderId = " + Eval("OrderId") %>'></asp:SqlDataSource>
                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                        <ItemTemplate>
                            <div style="padding-top: 20px; padding-left: 20px;padding-bottom:20px;float: left;width:100%;border:1px solid black">
                                <div style="padding-right: 20px; float: left">
                                    <asp:ImageButton ID="imgbtnGallery" runat="server" Height="150px" Width="150px" ImageUrl='<%# "data:Image/png;;base64," + Convert.ToBase64String((byte[])Eval("Image")) %>' OnClick="imgbtnGallery_Click" CommandName="product" CommandArgument='<%# Eval("ProductID") %>' /><br />
                                </div>
                                <div style="float: left">
                                    <asp:HyperLink ID="hypProduct" runat="server" NavigateUrl='<%# "~/ProductInfo.aspx?ProductId=" + Eval("ProductId") %>'><%# Eval("Name")%></asp:HyperLink><br />
                                    <div style="margin-top: 10px">
                                        Quantity : 
                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity")%>'></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ORDER].OrderId, [ORDER].date, [ORDER].discount, [ORDER].UserId, [ORDER].PaymentId, [ORDER].status, PAYMENT.TotalPaid FROM [ORDER] INNER JOIN PAYMENT ON [ORDER].OrderId = PAYMENT.OrderId"></asp:SqlDataSource>
    </asp:Panel>
</asp:Content>


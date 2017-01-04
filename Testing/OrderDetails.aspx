<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="Testing.OrderDetails" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script type="text/javascript">

        function startPage() {
            var e = document.getElementById('i0');
            var o = document.getElementById('o0');
            var c = document.getElementById('c0');

            e.style.display = 'block';
            o.style.display = 'none';
            c.style.display = 'block';
            
        }

        function openGetData(id)
        {
            var e = document.getElementById('i' + id);
            var o = document.getElementById('o' + id);
            var c = document.getElementById('c' + id);

            if(e)
            {
                e.style.display = 'block';
                o.style.display = 'none';
                c.style.display = 'block';
            }
        }

        function closeGetData(id)
        {
            var e = document.getElementById('i' + id)
            var o = document.getElementById('o' + id);
            var c = document.getElementById('c' + id);

            if (e) {
                e.style.display = 'none';
                o.style.display = 'block';
                c.style.display = 'none';
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="Panel1" runat="server">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
            <ItemTemplate>
                <tr style="clear: both">
                    <div style="background-color: #333; color: white; padding: 8px; clear: both">
                        <div id='o<%#Container.ItemIndex%>' style=" padding-left: 15px;padding-right:15px;cursor: pointer;float:left" onclick="openGetData(<%# Container.ItemIndex %>)">
                            +
                        </div>
                        <div id='c<%#Container.ItemIndex%>' style=" padding-left: 15px;padding-right:15px;display:none;cursor: pointer;float:left" onclick="closeGetData(<%# Container.ItemIndex %>)">
                            -
                        </div>

                        <div style="float: left; padding-right: 50px;">
                            <asp:Label ID="lblOrderNumber" runat="server" Text='<%# "ORDER #" + Eval("OrderId")%>'></asp:Label>
                        </div>
                        <div style="padding-right: 50px; float: left">
                            <asp:Label ID="lblDatePlace" runat="server" Text='<%# "Place on " + Eval("date", "{0:d}")%>'></asp:Label>
                        </div>
                        <div>
                            Total :
                        <asp:Label ID="lblTotal" runat="server" Text='<%# "RM " + String.Format("{0:f2}",Eval("TotalPaid"))%>'></asp:Label>
                        </div>
                    </div>
                    <div id='i<%# Container.ItemIndex%>' style="display:none">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand='<%# "SELECT ORDERDETAIL.ProductId, ORDERDETAIL.OrderId, ORDERDETAIL.Quantity, ORDERDETAIL.TotalPrice, PRODUCT.Name, PRODUCT.Description, PRODUCT.Model, PRODUCT.Price, PRODUCT.ArtistId, PRODUCT.CategoryId, PRODUCT.Image FROM ORDERDETAIL INNER JOIN PRODUCT ON ORDERDETAIL.ProductId = PRODUCT.ProductId WHERE ORDERDETAIL.OrderId = " + Eval("OrderId") %>'></asp:SqlDataSource>
                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                        <ItemTemplate>

                            <div  style="padding-top: 20px; padding-left: 20px; padding-bottom: 20px; border: 1px solid black; background-color: white; border-top: none; clear: both; height: 150px">
                                <div style="padding-right: 20px; float: left">
                                    <asp:ImageButton ID="imgbtnGallery" runat="server" Height="150px" Width="150px" ImageUrl='<%# "data:Image/png;;base64," + Convert.ToBase64String((byte[])Eval("Image")) %>' OnClick="imgbtnGallery_Click" CommandName="product" CommandArgument='<%# Eval("ProductID") %>' /><br />
                                </div>
                                <div>
                                    <asp:HyperLink ID="hypProduct" runat="server" NavigateUrl='<%# "~/ProductInfo.aspx?ProductId=" + Eval("ProductId") %>'><%# Eval("Name")%></asp:HyperLink><br />
                                    <div style="">
                                        Quantity : 
                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity")%>'></asp:Label>
                                    </div>
                                </div>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>
                        </div>
                </tr>
                <div style="margin-top: 20px"></div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ORDER].OrderId, [ORDER].date, [ORDER].discount, [ORDER].UserId, [ORDER].status, PAYMENT.TotalPaid FROM [ORDER] INNER JOIN PAYMENT ON [ORDER].OrderId = PAYMENT.OrderId WHERE ([ORDER].UserId = @UserId)">
            <SelectParameters>
                <asp:Parameter Name="UserId" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>

    <div style="text-align:center;padding-top:30px">
        <asp:Label ID="lblNoRecord" runat="server" Text="You do not have any purchase history"></asp:Label>
    </div>
</asp:Content>


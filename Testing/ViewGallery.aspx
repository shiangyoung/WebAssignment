<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ViewGallery.aspx.cs" Inherits="Testing.ViewGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtSearch.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "ViewGallery.aspx/GetProductName",
                        data: "{ 'pre':'" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return { value: item }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert(textStatus);
                        }
                    })
                }
            })
        })
    </script>

    <div style="margin-bottom:35px">
        <div style="margin-right: 20px; float: left">
            <asp:Label ID="lblSort" runat="server" Text="Sort : "></asp:Label>
            <asp:DropDownList ID="ddlSort" runat="server" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem>Relevance</asp:ListItem>
                <asp:ListItem>Price : High to Low</asp:ListItem>
                <asp:ListItem>Price : Low to High</asp:ListItem>
            </asp:DropDownList>
        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT *  FROM [PRODUCT]" OnSelected="SqlDataSource1_Selected"></asp:SqlDataSource>

        <div style="float: left">
            <asp:Label ID="lblCategory" runat="server" Text="Category"></asp:Label>
            <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="CategoryId" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem>None</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name], [CategoryId] FROM [CATEGORY]"></asp:SqlDataSource>
        </div>


        <div style="float: right">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="textboxAuto" Width="200px"></asp:TextBox>&nbsp;
        <div style="margin-left: 10px; float: right">
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
        </div>
        </div>
    </div>

    <div style="width: 100%; text-align: center; clear: both;">
        <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Left">
            <asp:Repeater ID="rptProduct" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="rptProduct_ItemDataBound">
                <ItemTemplate>
                    <div style="display: inline-block" runat="server">
                        <div class="galleries" style="margin-top: 10px; margin-left: 20px">
                            <div style="height: 240px; width: 240px; text-align: center; vertical-align: central">
                                <asp:ImageButton ID="imgbtnGallery" runat="server" Height="230px" Width="230px" ImageUrl='<%# "data:Image/png;;base64," + Convert.ToBase64String((byte[])Eval("Image")) %>' OnClick="imgbtnGallery_Click" CommandName="product" CommandArgument='<%# Eval("ProductID") %>' /><br />
                            </div>
                            <div style="text-align: center">
                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name")%>' Font-Size="18px"></asp:Label>
                            </div>
                            <div style="text-align: center">
                                <asp:Label ID="lblPrice" runat="server" Text='<%# "RM " + String.Format("{0:f2}",Eval("Price"))%>' ForeColor="ForestGreen" Font-Size="16px"></asp:Label>
                            </div>
                            <div style="text-align: center; margin-top: 5px">
                                <asp:Button ID="btnAddToCart" runat="server" Text="Add to cart" OnClick="btnAddToCart_Click" Width="130px" CommandArgument='<%# Eval("ProductID") %>' BackColor="#f37021" ForeColor="White" BorderWidth="0" Height="20px"></asp:Button>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>
    </div>

    <div style="text-align:center;padding-top:30px">
     <asp:Label ID="lblNoRecord" runat="server" Text="No gallery can be found"></asp:Label>
</div>
</asp:Content>

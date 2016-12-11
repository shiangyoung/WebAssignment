<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ViewGallery.aspx.cs" Inherits="Testing.ViewGallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"  />
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

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT *  FROM [PRODUCT] " FilterExpression="Name LIKE '{0}%'">

        <FilterParameters>
            <asp:ControlParameter Name="Name" ControlID="txtSearch" PropertyName="Text" Type="String"/>
        </FilterParameters>
    </asp:SqlDataSource>
    
    <asp:TextBox ID="txtSearch" runat="server" CssClass="textboxAuto"></asp:TextBox>&nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
    
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
                    <div style="text-align:center"><asp:Button ID="btnAddToCart" runat="server" Text="Add to cart" OnClick="btnAddToCart_Click" BackColor="Transparent" BorderWidth="0" CommandArgument='<%# Eval("ProductID") %>'></asp:Button></div>
                </div>
            </div>
        </ItemTemplate>
        </asp:Repeater>
        </div>
    </asp:Panel>
    
</asp:Content>

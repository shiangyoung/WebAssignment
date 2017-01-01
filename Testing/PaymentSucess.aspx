<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.Master"  CodeBehind="PaymentSucess.aspx.cs" Inherits="Testing.PaymentSucess" %>


<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1" >
    <asp:Label ID="Label1" runat="server" Text="Purchase Summary" Font-Size="X-Large"></asp:Label>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"  OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
    <Columns>
        <asp:BoundField DataField="ProductId" HeaderText="Product Id" />
        <asp:BoundField DataField="Name" HeaderText="Product Name" />
        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
        <asp:BoundField DataField="TotalPrice" HeaderText="Unit Price" />
    </Columns>
</asp:GridView>
<br /> 
     &nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label2" ForeColor="Red"   runat="server" Text="Total (RM) : " Font-Size="X-Large"></asp:Label> <asp:Label ID="lblTotal" ForeColor="Red"   runat="server" Text="" Font-Size="X-Large"></asp:Label>

    <br />
    <br />
    <asp:Button ID="Button1"  runat="server" Text="Print Receipt" OnClick="Button1_Click" />
     <br />
    <br />
    <br />
    <asp:HyperLink ID="HyperLink2" runat="server">Return Home</asp:HyperLink>

</asp:Content>
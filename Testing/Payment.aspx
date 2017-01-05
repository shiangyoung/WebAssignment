<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.Master"  CodeBehind="Payment.aspx.cs" Inherits="Testing.Payment" %>
<%@ PreviousPageType VirtualPath="~/ProductCart.aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
    
    <div>

        <asp:FormView ID="FormViewPayment"  DataKeyNames="PaymentId" runat="server" DefaultMode="Insert" InsertMethod="FormViewPayment_InsertItem" ItemType="Testing.Models.PAYMENT" OnPageIndexChanging="FormViewPayment_PageIndexChanging">
                <InsertItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text="Shipping Address:"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox runat="server" ID="txtboxAddress" BorderStyle="Solid" TextMode="MultiLine" Width="200px" Height="70px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" EnableClientScript="false" ControlToValidate="txtboxAddress" runat="server" ErrorMessage="Address is needed">*Address is required!</asp:RequiredFieldValidator>
                    <br />
                    <br />
                     <asp:Label ID="Label2" runat="server" Text="Email :"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtboxEmail" runat="server"  Width="195px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtboxEmail" EnableClientScript="false" runat="server" ErrorMessage="Email is required!">*Email is required</asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:Label ID="Label8" runat="server" Text="Total Amount(RM) :"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtboxTotal" runat="server" Text='<%# Bind("TotalPaid") %>' Enabled="false"></asp:TextBox>
                      <br />
                      <br />

        <asp:Label ID="Label5" runat="server" Text="Credit Card Type"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        <asp:RadioButtonList ID="rblType" runat="server">
            <asp:ListItem>Visa</asp:ListItem>
            <asp:ListItem>Master</asp:ListItem>
        </asp:RadioButtonList>
        <br />      
        <asp:Label ID="Label6" runat="server" Text="Credit Card Number:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtboxCreditCard"  runat="server" Width="200px"></asp:TextBox>
                   
        <asp:RequiredFieldValidator runat="server" ErrorMessage="Credit Card Number is required" ControlToValidate="txtboxCreditCard" EnableClientScript="false">*Credit Card Number is required</asp:RequiredFieldValidator>
        
        <asp:RegularExpressionValidator ID="RegularExpressionValidator3"  ControlToValidate="txtboxCreditCard" runat="server" ErrorMessage="Invalid Credit Card Number" EnableClientScript="false" ValidationExpression="\d{14}">*Invalid Credit Card Number</asp:RegularExpressionValidator>
                    
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Pay" CommandName="Insert" OnClick="Button1_Click"/>
        <asp:Button ID="Button2" runat="server" style="margin-left: 22px" Text="Clear" CommandName="Cancel" />

        <%--<asp:Label ID="lblSummary" runat="server"></asp:Label>
        
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" HeaderText="The following problems have been encountered."/>--%>
                </InsertItemTemplate>

        </asp:FormView>
        
    </div>

</asp:Content>

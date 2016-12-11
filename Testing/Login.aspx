<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Testing.LoginPage" %>
 

<asp:Content id="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">  
    <style type="text/css">
     .LoginDiv{
    text-align:center
        }
        </style>
    <div class="LoginDiv">
    <asp:LoginView ID="LoginView1" runat="server" >
        <AnonymousTemplate>
            <asp:Login ID="Login1" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#333333" Height="257px" Width="500px" style="margin-left: 0px" DestinationPageUrl="~/ViewGallery.aspx">
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
                <TextBoxStyle Font-Size="0.8em" Width="210px" Height="25px"/>
                <TitleTextStyle BackColor="#507CD1" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
            </asp:Login>
        </AnonymousTemplate>
    </asp:LoginView>
    </div>
</asp:Content>
    
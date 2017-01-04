<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UpdateProfile.aspx.cs" Inherits="Testing.UpdateProfile" %>


<asp:Content ID="ContentUpdateProfile" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div style="width: 100%; align-items: center">
        <br />
        <table class="auto-style1">
            <tr>
                <td>Name</td>
                <td>
                    <asp:TextBox ID="tbName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Email</td>
                <td>
                    <asp:TextBox ID="tbEmail" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Date Of Birth</td>
                <td>
                    <asp:DropDownList runat="server" OnSelectedIndexChanged="updateDropDownList" ID="ddlMonth" AutoPostBack="True">
                        <asp:ListItem Value=""></asp:ListItem>
                        <asp:ListItem Value="1">Jan</asp:ListItem>
                        <asp:ListItem Value="2">Feb</asp:ListItem>
                        <asp:ListItem Value="3">Mar</asp:ListItem>
                        <asp:ListItem Value="4">Apr</asp:ListItem>
                        <asp:ListItem Value="5">May</asp:ListItem>
                        <asp:ListItem Value="6">Jun</asp:ListItem>
                        <asp:ListItem Value="7">Jul</asp:ListItem>
                        <asp:ListItem Value="8">Aug</asp:ListItem>
                        <asp:ListItem Value="9">Sep</asp:ListItem>
                        <asp:ListItem Value="10">Oct</asp:ListItem>
                        <asp:ListItem Value="11">Nov</asp:ListItem>
                        <asp:ListItem Value="12">Dec</asp:ListItem>
                    </asp:DropDownList>

                    <asp:DropDownList runat="server" ID="ddlDay">
                    </asp:DropDownList>
                    <asp:DropDownList runat="server" ID="ddlYear">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td>Contact Number</td>
                <td>
                    <asp:TextBox ID="tbContact" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Address</td>
                <td>
                    <asp:TextBox ID="tbAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="Update" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:ChangePassword ID="ChangePassword1" runat="server" OnChangedPassword="ChangePassword1_ChangedPassword">
                        <SuccessTemplate>
                            <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                                <tr>
                                    <td>
                                        <table cellpadding="0">
                                            <tr>
                                                <td align="center" colspan="2">Change Password Complete</td>
                                            </tr>
                                            <tr>
                                                <td>Your password has been changed!<br /> Please Log in again.</td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="2">
                                                    <asp:Button ID="ContinuePushButton" runat="server" CausesValidation="False" CommandName="Continue" OnClick="ContinuePushButton_Click" Text="Continue" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </SuccessTemplate>
                    </asp:ChangePassword>
                </td>
            </tr>
        </table>


    </div>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>


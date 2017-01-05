<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UpdateProfile.aspx.cs" Inherits="Testing.UpdateProfile" %>


<asp:Content ID="ContentUpdateProfile" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div style="width: 100%; align-items: center">
        <br />
        <div class="container">
            <h1>Edit Profile</h1>

        </div>
        <table class="auto-style1">
            <tr>
                <td>Name</td>
                <td>
                    <asp:TextBox ID="tbName" runat="server" class="form-control"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Email</td>
                <td>
                    <asp:TextBox ID="tbEmail" runat="server" class="form-control"></asp:TextBox>
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
                    <asp:TextBox ID="tbContact" runat="server" class="form-control"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Address</td>
                <td>
                    <asp:TextBox ID="tbAddress" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="Update" class="btn btn-primary" />
                </td>
            </tr>
            <hr />
            
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:ChangePassword ID="ChangePassword1" runat="server" OnChangedPassword="ChangePassword1_ChangedPassword">
                        <ChangePasswordTemplate>
                            <table cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
                                <tr>
                                    <td>
                                        <table cellpadding="0">
                                            <tr>
                                                <td align="center" colspan="2">Change Your Password</td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Password:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">New Password:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" ErrorMessage="New Password is required." ToolTip="New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry." ValidationGroup="ChangePassword1"></asp:CompareValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2" style="color: Red;">
                                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword" Text="Change Password" ValidationGroup="ChangePassword1" class="btn btn-primary" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </ChangePasswordTemplate>
                        <SuccessTemplate>
                            <table cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
                                <tr>
                                    <td>
                                        <table cellpadding="0">
                                            <tr>
                                                <td align="center" colspan="2">Change Password Complete</td>
                                            </tr>
                                            <tr>
                                                <td>Your password has been changed!<br />
                                                    Please Log in again.</td>
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
    <%--<div class="container">
        <h1>Edit Profile</h1>
        <hr>


        <!-- edit form column -->
        <div class="col-md-9 personal-info">

            <h3>Personal info</h3>

            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-lg-3 control-label">Name:</label>
                    <div class="col-lg-8">
                        <asp:TextBox ID="tbName" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label">Email:</label>
                    <div class="col-lg-8">
                        <asp:TextBox ID="tbEmail" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label">Address:</label>
                    <div class="col-lg-8">
                        <asp:TextBox ID="tbAddress" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">Contact:</label>
                    <div class="col-md-8">
                        <asp:TextBox ID="tbContact" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">Date Of Birth:</label>
                    <div class="col-md-8">
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
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-3 control-label"></label>
                    <div class="col-md-8">
                        <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="Update" class="btn btn-primary" />

                    </div>
                </div>
            </form>
        </div>
    </div>
    <hr />
    <div class="container">
        <div class="col-md-9 personal-info">

            <h3>Personal    </h3>

            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <div class="col-lg-8">
                        <asp:ChangePassword ID="ChangePassword2" runat="server" OnChangedPassword="ChangePassword1_ChangedPassword">
                            <SuccessTemplate>
                                <table cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
                                    <tr>
                                        <td>
                                            <table cellpadding="0">
                                                <tr>
                                                    <td align="center" colspan="2">Change Password Complete</td>
                                                </tr>
                                                <tr>
                                                    <td>Your password has been changed!<br />
                                                        Please Log in again.</td>
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
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label">Email:</label>
                    <div class="col-lg-8">
                        <asp:TextBox ID="TextBox2" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
        </div>
    </div>
    <hr>--%>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>


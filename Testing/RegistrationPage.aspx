<%@ Page Title="Registration" MasterPageFile="~/MasterPage.Master" Language="C#" AutoEventWireup="true" CodeBehind="RegistrationPage.aspx.cs" Inherits="Testing.RegistrationPage" %>
<asp:Content ID="AddProductContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
<style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 203px;
        }
        .auto-style3 {
            width: 203px;
            text-align: right;
        }
        .auto-style4 {
            width: 218px;
        }
        .auto-style5 {
            width: 203px;
            text-align: right;
            height: 29px;
        }
        .auto-style6 {
            width: 218px;
            height: 29px;
        }
        .auto-style7 {
            height: 29px;
        }
        .auto-style8 {
            width: 203px;
            text-align: right;
            height: 194px;
        }
        .auto-style9 {
            width: 218px;
            height: 194px;
        }
        .auto-style10 {
            height: 194px;
        }
    </style>

                <table class="auto-style1">
                    <tr>
                        <td class="auto-style3">Username:</td>
                        <td class="auto-style4">
                            <asp:TextBox ID="tbUserName" runat="server" Width="205px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Username." ControlToValidate="tbUserName" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Password:</td>
                        <td class="auto-style4">
                            <asp:TextBox ID="tbPassword" TextMode="Password" runat="server" Width="205px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Password" ControlToValidate="tbPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Confirm Password:</td>
                        <td class="auto-style4">
                            <asp:TextBox ID="tbConfirmPassword" TextMode="Password" runat="server" Width="205px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Enter Password" ControlToValidate="tbPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                            <br />
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Both Password must be same." ControlToCompare="tbPassword" ControlToValidate="tbConfirmPassword" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Name:</td>
                        <td class="auto-style4">
                            <asp:TextBox ID="tbName" runat="server" Width="205px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please Enter Name." ControlToValidate="tbName" ForeColor="Red"></asp:RequiredFieldValidator>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Email:</td>
                        <td class="auto-style4">
                            <asp:TextBox ID="tbEmail" runat="server" Width="205px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Email." ControlToValidate="tbEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please Enter valid Email." ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="tbEmail"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Address:</td>
                        <td class="auto-style4">
                            <asp:TextBox ID="tbAddress" runat="server" Width="205px" TextMode="MultiLine"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Enter Address" ControlToValidate="tbAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                            .</td>
                    </tr>
                    <tr>
                        <td class="auto-style5">Contact No:</td>
                        <td class="auto-style6">
                            <asp:TextBox ID="tbContact" runat="server" Width="205px"></asp:TextBox>
                        </td>
                        <td class="auto-style7">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter Contact Number." ControlToValidate="tbContact" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style8">Date Of Birth:</td>
                        <td class="auto-style9">
                            
                            <asp:Calendar ID="calendarBirth" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="30px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="205px">
                                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
                                <DayStyle Width="14%" />
                                <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                                <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                                <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                                <TodayDayStyle BackColor="#CCCC99" />
                            </asp:Calendar>
                        </td>
                        <td class="auto-style10">
                            </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">&nbsp;</td>
                        <td class="auto-style4">
                            <asp:Button ID="btnReset" runat="server" Text="Reset" />
                            <asp:Button ID="btnSend" runat="server" OnClick="btnSend_Click" Text="Register" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
</asp:Content>

<%@ Page Title="Registration" MasterPageFile="~/MasterPage.Master" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Testing.Register" %>


   
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
                width: 316px;
            }
        .auto-style5 {
            width: 203px;
            text-align: right;
            height: 29px;
        }
        .auto-style6 {
            width: 316px;
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
            width: 316px;
            height: 194px;
        }
        .auto-style10 {
            height: 194px;
        }
    </style>


  
    <div>
            <div>

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
                            
                            <table class="auto-style1">
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="DropDownList1" runat="server" Width="85px" DataSourceID="XmlDataSource1" DataTextField="id" DataValueField="id" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" >
                                        </asp:DropDownList>
                                        
                                    </td>
                                    <td><asp:DropDownList ID="DropDownList2" runat="server" Width="90px" DataSourceID="XmlDataSource2" DataTextField="month" DataValueField="month">
                                        </asp:DropDownList></td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList3" runat="server" Width="90px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/XMLFile1.xml" XPath="/id"></asp:XmlDataSource>
                            <asp:XmlDataSource ID="XmlDataSource2" runat="server" DataFile="~/XMLFile1.xml" XPath="/month"></asp:XmlDataSource>
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

            </div>
    </div>
    
    </asp:Content>


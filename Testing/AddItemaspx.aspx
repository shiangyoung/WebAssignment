﻿<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AddItemaspx.aspx.cs" Inherits="Testing.AddItemaspx" %>

<asp:content id="Content1" contentplaceholderid="ContentPlaceHolder1" runat="server">
    <div>
        <asp:FormView ID="fvAddItem" runat="server" DefaultMode="Insert" ItemType="Testing.Models.PRODUCT" InsertMethod="fvAddItem_InsertItem">
            <InsertItemTemplate>
                Image : 
                <asp:FileUpload ID="imageUpload" runat="server" />
                <br />
                 Name :
                <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' ></asp:TextBox>
                <br />
                Model :
                <asp:TextBox ID="txtModel" runat="server" Text='<%# Bind("Model") %>' ></asp:TextBox>
                <br />
                Stock :
                <asp:TextBox ID="txtStock" runat="server" Text='<%# Bind("Stock") %>' ></asp:TextBox>
                <br />
                Price :
                <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' ></asp:TextBox>
                <br />
                Category :  
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="CategoryId" SelectedValue='<%# Bind("CategoryId") %>'>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CATEGORY]"></asp:SqlDataSource>
                <br />
                <asp:Button ID="btnInsert" runat="server" Text="Insert" CommandName="Insert" />
            </InsertItemTemplate>
            </asp:FormView>
            </div>
            </asp:content>

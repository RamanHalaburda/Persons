<%@ Page Title="Passports" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Passports.aspx.cs" Inherits="Persons.Passports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        &nbsp;</p>
    <p>
&nbsp;Серия пасспорта:
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    </p>
    <p>
        Номер пасспорта:
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    </p>
    <p>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Показать" />
    </p>
    <p>
        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>

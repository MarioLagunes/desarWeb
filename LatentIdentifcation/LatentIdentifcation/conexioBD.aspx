<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="conexioBD.aspx.cs" Inherits="LatentIdentifcation.conexioBD" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:gridview runat="server" AutoGenerateColumns="False" DataKeyNames="IDBUSQUEDA" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="IDBUSQUEDA" HeaderText="IDBUSQUEDA" InsertVisible="False" ReadOnly="True" SortExpression="IDBUSQUEDA" />
                    <asp:BoundField DataField="IDUSUARIO" HeaderText="IDUSUARIO" SortExpression="IDUSUARIO" />
                    <asp:BoundField DataField="PATHBUSQUEDA" HeaderText="PATHBUSQUEDA" SortExpression="PATHBUSQUEDA" />
                    <asp:BoundField DataField="FECHA" HeaderText="FECHA" SortExpression="FECHA" />
                </Columns>
            </asp:gridview>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LatentIdentificationDataBaseConnectionString %>" SelectCommand="SELECT * FROM [BUSQUEDA]"></asp:SqlDataSource>
        </div>
       
    </form>
</body>
</html>


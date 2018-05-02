<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="conexioBD.aspx.cs" Inherits="LatentIdentifcation.conexioBD" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Latent Module</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link href="../Pages/styleResponsive.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav" id="myTopNav">
            <a href="../Pages/home.html" class="active"><img class="imagen" src="../imgs/home.png" /> Home</a>
            <div class="dropdown">
                <button class="dropbtn">
                    <img class="imagen" src="../imgs/fingerPrint.png" />
                    Modules
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content" id="myDropdown">
                    <a href="#">---</a>
                    <a href="#">---</a>
                    <a href="#">---</a>
                    <a href="../Pages/LatentModule.html">Latent Identification</a>
                    <a href="../conexioBD.aspx">Report</a>
                </div>
            </div>
            <a href="javascript:void(0);" style="font-size:15px;" class="icon" onclick="myFunction()">&#9776;</a>
        </div>
        <script>
            function myFunction() {
                var x = document.getElementById("myTopNav");
                if (x.className === "topnav") {
                    x.className += " responsive";
                } else {
                    x.className = "topnav";
                }
            }
        </script>
        <div class="row">
            <div class="col-12">
                <asp:gridview class="gridNAME" runat="server" AutoGenerateColumns="False" DataKeyNames="IDUSUARIO" DataSourceID="SqlDataSource2" BackColor="#9AB2CE" HorizontalAlign="Center" OnSelectedIndexChanged="Unnamed1_SelectedIndexChanged" CssClass="alienarCentro" >
                    <Columns>
                        <asp:BoundField DataField="IDUSUARIO" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="IDUSUARIO" ItemStyle-CssClass="alinearCentroCeldas" />    
                        <asp:BoundField DataField="NOMBRE" HeaderText="NOMBRE" SortExpression="NOMBRE" ItemStyle-CssClass="alinearCentroCeldas" />
                        <asp:BoundField DataField="Column1" HeaderText="SEARCHES" SortExpression="Column1" ReadOnly="True" ItemStyle-CssClass="alinearCentroCeldas" />
                        <asp:BoundField DataField="Column2" HeaderText="MATCHES" SortExpression="Column2" ReadOnly="True"  ItemStyle-CssClass="alinearCentroCeldas" />
                    </Columns>
                    <EditRowStyle BackColor="White" Font-Names="Century" />
                    <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    <RowStyle BackColor="White" Font-Bold="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:gridview> 
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LatentIdentificationDataBaseConnectionString %>" SelectCommand="SELECT USUARIO.IDUSUARIO, USUARIO.NOMBRE, COUNT(BUSQUEDA.IDBUSQUEDA), COUNT(MATCH.IDMATCH) 
                                FROM USUARIO, MATCH, BUSQUEDA 
                                WHERE USUARIO.IDUSUARIO = MATCH.IDUSUARIO AND USUARIO.IDUSUARIO = BUSQUEDA.IDUSUARIO
                                GROUP BY USUARIO.IDUSUARIO, USUARIO.NOMBRE;">
                </asp:SqlDataSource>
            </div>
        </div>
        <div class="row">
            <div class="col-6">
                <input type="button" class="styleInputReportRight" id="cancelar" onclick="Cancelar()" value="Cancelar" />
            </div>
            <div class="col-6">
                <input type="button" class="styleInputReport" id="Imprimir" onclick="Aceptar()" value="Aceptar" />
            </div>
        </div>



        <script>

            function Cancelar() {
                location = "../PrintVerification.aspx";
            }

            function Aceptar() {
                location = "../PrintVerification.aspx";
            }
        </script>
       
    </form>
</body>
</html>
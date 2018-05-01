<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PruebaMatch.aspx.cs" Inherits="LatentIdentifcation.PruebaMatch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Print Verification</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="../Content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="~/ext_tools/font-awesome/css/font-awesome.min.css" />
    <script type="text/javascript" src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">

        <div class="page-header">
            &nbsp;<h1 style="text-align: center">
                <img alt="" class="img-rounded" src="Images/fingerprintLogo.png" />Print Verification System:<small style="text-align: center"> Testing a web service</small></h1>
        </div>

        <!-- Bootstrap Upload Control - START -->
        <div class="container">
            <form id="form1" runat="server" data-toggle="validator">
                <div class="row">
                    <div class="col-sm-2 text-right">
                        <span class="btn btn-success disabled">Your Key</span><i class="glyphicon glyphicon-arrow-right"></i>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-key"></i></span>
                            <asp:TextBox ID="tboxKey" runat="server" class="form-control" placeholder="Insert your Key here" required="required"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <div class="row">
                    <div class="col-sm-2 text-right">
                        <span class="btn btn-success disabled">Print - Template</span><i class="glyphicon glyphicon-arrow-right"></i>
                    </div>
                    <div class="col-sm-2">
                        <asp:FileUpload ID="template" name="files" runat="server" />
                    </div>
                    <div class="col-sm-8">
                        <p class="text-center">
                            <asp:Label ID="lbResultImg" runat="server" class="alert-danger btn-lg" Visible="False"></asp:Label>
                        </p>
                    </div>
                </div>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <div class="row">
                    <div class="col-sm-2 text-right">
                        <span class="btn btn-success disabled">Print - Query</span><i class="glyphicon glyphicon-arrow-right"></i>
                    </div>
                    <div class="col-sm-2">
                        <asp:FileUpload ID="query" name="files" runat="server" multiple="multiple"/>
                    </div>
                    <div class="col-sm-8">
                        <p class="text-right">
                            <asp:Button ID="Verify" runat="server" Text="Verify" class="btn btn-lg btn-primary" OnClick="Verify_Click" />
                        </p>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div>
        <p class="text-center">
            <asp:Label ID="lbResult" runat="server" class="alert-danger btn-lg" Visible="False"></asp:Label>
        </p>
    </div>
    <hr/>
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-sm-4"></div>
                <div class="col-sm-4">
                    <span class="text-muted">Created by Octavio Loyola-González</span>
                </div>
                <div class="col-sm-4"></div>
            </div>
        </div>
    </footer>
</body>
</html>

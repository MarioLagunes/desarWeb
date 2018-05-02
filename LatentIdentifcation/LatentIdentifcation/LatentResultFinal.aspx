<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LatentResultFinal.aspx.cs" Inherits="LatentIdentifcation.LatentResultFinal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Latent Module</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link href="../Pages/styleResponsive.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
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
                    <a href="../PrintVerification.aspx">Latent Identification</a>
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
            <div class="col-11">
                <select class="positionOptionsResult" id="regions" onchange="drawImage(this.value);" required>
                    <option value="minutiaOriginal">Your minuta</option>
                    <option value="optionOne">Option 1</option>
                    <option value="optionTwo">Option 2</option>
                    <option value="optionThree">Option 3</option>
                    <option value="optionFour">Option 4</option>
                    <option value="select..." selected="selected">Select...</option>
                </select>
            </div>
            <div class="col-1">
                <button class="styleInputMatch" disabled id="hazMatch" onclick="quieresMatch()">Match</button>
            </div>
        </div>
        <div class="row">
            <div class="col-12" id="lienzo">
            </div>
        </div>
        <!--<div class="row">
        <div class="col-12" id="resultadoImagen"></div>
    </div>-->
        <div class="row">
            <div class="col-12" id="infoMatch"></div>
        </div>
        <div class="row">
            <div>
                <div class="col-6"><label class="positionLabel" for="region">Region:</label></div>
                <div class="col-6">
                    <select class="positionOptions" id="regionOptions" disabled></select>
                </div>

            </div>
        </div>
        <div class="row">
            <div class="col-6"><label class="positionLabelSide" for="side">Side:</label></div>
            <div class="col-6">
                <select class="positionSide" id="sideOptions" name="sideOptions" required disabled></select>
            </div>
        </div>

        <script>
            var regio = "";
            var sid = "";
            var regionCmb = document.getElementById("regionOptions");
            var sideCmb = document.getElementById("sideOptions");
            var img;
            var lX1 = [];
            var lX2 = [];
            var lY1 = [];
            var lY2 = [];

            var dec = decodeURI(location.search);
            var context;
            var listaX1 = [];
            var listaX2 = [];
            var listaY1 = [];
            var listaY2 = [];

            llenarListas(dec, 2, listaX1, listaX2, listaY1, listaY2);
            cadVariables = dec.substring(1, dec.length);
            var regionMil = getParameterByName("x0");
            var sideMil = getParameterByName("x1");
            regio = regionMil;
            sid = sideMil;
            console.log("regio " + regio);
            console.log("side " + sid);
            var miOptionRegion = document.createElement("option");
            miOptionRegion.text = regio;
            regionCmb.add(miOptionRegion);
            var miOptionSide = document.createElement("option");
            miOptionSide.text = sid;
            sideCmb.add(miOptionSide);
            //var imagens = src;
            var canvas;
            var ctx;
            var img = new Image();
            crearCanvas();

            function llenarListas(string, Xinicial, x1, x2, y1, y2) {
                var listaDeListas = [x1, x2, y1, y2];
                var elementosEnString = string.split("&x");
                elementosEnString = (elementosEnString.length - Xinicial) / 4;
                //console.log("numero de x es: " + elementosEnString);
                var cadenaX = "x" + Xinicial.toString();
                for (i = 0; i < 4; i++) {
                    for (k = 0; k < elementosEnString; k++) {
                        listaDeListas[i].push(parseFloat(getParameterByName(cadenaX)));
                        Xinicial++;
                        var cadenaX = "x" + Xinicial.toString();
                    }
                }
            }

            function getParameterByName(name, url) {
                if (!url) url = window.location.href;
                name = name.replace(/[\[\]]/g, "\\$&");
                var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                    results = regex.exec(url);
                if (!results) return null;
                if (!results[2]) return '';
                return decodeURIComponent(results[2].replace(/\+/g, " "));
            }

            function crearCanvas() {
                console.log("Estoy entrando aqui guapo");
                var canvasDiv = document.getElementById("lienzo");
                canvas = document.createElement('canvas');
                canvas.setAttribute('id', 'canvas');
                canvas.setAttribute('class', "styleInputImg");
                canvasDiv.appendChild(canvas);
                if (typeof G_vmlCanvasManager != 'undefined') {
                    canvas = G_vmlCanvasManager.initElement(canvas);
                }
                context = canvas.getContext("2d");
                document.getElementById("canvas").style.overflow = "hidden";
                getRutaMil();
                
            }

            function dibujarMinutias() {
                for (var i = 0; i < listaX1.length; i++) {
                    //dibujar circulos:
                    context.fillStyle = 'rgba(255, 0, 0, 0.1)';
                    context.strokeStyle = 'rgba(255, 0, 0, 1)';
                    context.lineWidth = 3;
                    context.beginPath();
                    context.arc(listaX1[i], listaY1[i], 6, 0, 2 * Math.PI);
                    context.fill();
                    context.stroke();

                    //dibujar lineas
                    context.lineWidth = 3;
                    context.strokeStyle = "#f00";
                    context.beginPath();
                    context.moveTo(listaX1[i], listaY1[i]);
                    context.lineTo(listaX2[i], listaY2[i]);
                    context.stroke();

                }
            }

            var raizita = "";
            var ruts;
            var txt;
            function getRutaMil() {
                //ruts = $.get("/Home/Ruta", function () { alert('ohh si bb') });
                //console.log(ruts);
                var arrayData = new Array();
                var archivoTxt = new XMLHttpRequest();
                var fileRuta = "/Pages/archivo.txt";
                console.log("soy fil: " + fileRuta);
                archivoTxt.open("GET", fileRuta, false);
                archivoTxt.send(null);
                txt = archivoTxt.responseText;
                console.log(txt);
			}
			//funcion que dibuja una imagen de forma responsiva
			function drawImageProp(ctx, img, x, y, w, h, offsetX, offsetY) {
				if (arguments.length === 2) {
					x = y = 0;
					w = ctx.canvas.width;
					h = ctx.canvas.height;
				}
				/// default offset is center
				offsetX = typeof offsetX === 'number' ? offsetX : 0.5;
				offsetY = typeof offsetY === 'number' ? offsetY : 0.5;
				/// keep bounds [0.0, 1.0]
				if (offsetX < 0) offsetX = 0;
				if (offsetY < 0) offsetY = 0;
				if (offsetX > 1) offsetX = 1;
				if (offsetY > 1) offsetY = 1;
				var iw = img.width,
					ih = img.height,
					r = Math.min(w / iw, h / ih),
					nw = iw * r,   /// new prop. width
					nh = ih * r,   /// new prop. height
					cx, cy, cw, ch, ar = 1;
				/// decide which gap to fill
				if (nw < w) ar = w / nw;
				if (nh < h) ar = h / nh;
				nw *= ar;
				nh *= ar;
				/// calc source rectangle
				cw = iw / (nw / w);
				ch = ih / (nh / h);
				cx = (iw - cw) * offsetX;
				cy = (ih - ch) * offsetY;
				/// make sure source rectangle is valid
				if (cx < 0) cx = 0;
				if (cy < 0) cy = 0;
				if (cw > iw) cw = iw;
				if (ch > ih) ch = ih;
				/// fill image in dest. rectangle
				ctx.drawImage(img, cx, cy, cw, ch, x, y, w, h);
			}

			function dibujarImagen() {
				if (document.getElementById("lienzo").offsetWidth < img.width) {
					var width = document.getElementById("lienzo").offsetWidth;
					var diferenciaEnX = document.getElementById("lienzo").offsetWidth / img.width;
					var height = img.height * diferenciaEnX;
					img.setAttribute('class', 'styleInputImg');
					myFunction(this.src);
					//codigo = "a";
					canvas.setAttribute("width", width);
					canvas.setAttribute("height", height);
					canvas.setAttribute('class', 'styleInputImg');
					context = canvas.getContext("2d");
					
					drawImageProp(context, img, 0, 0, document.getElementById("canvas").offsetWidth, document.getElementById("canvas").offsetHeight, -1, -1);
					return true;
				}
				return false;
				
			}

            function drawImage(valor) {
                if (context) {
                    if (valor == 'minutiaOriginal') {
                        img.src = txt;
                        img.onload = function () {
                            
							if (!dibujarImagen()){
								width = this.width;
								height = this.height;
								canvas.width = width;
								canvas.height = height;
								context.drawImage(img, (0), (0));
							}
                            dibujarMinutias();
                            context = canvas.getContext("2d");

                        }
                        document.getElementById('infoMatch').innerHTML = '<label class="positionNombreCenter"> </label>';
                        ponBotonesDisabled();
                        
                    }
                    else if (valor == 'optionOne') {
                        context.clearRect(0, 0, canvas.width, canvas.height);
                        canvas.style.display = "block";
                        document.getElementById("canvas").style.overflowY = "hidden";
                        img.src = "../imgs/minutiaMatch.png";
                        console.log("soy imageng " + img.src);
                        img.onload = function () {
                            
							if(!dibujarImagen()){
								width = this.width;
								height = this.height;
								canvas.width = width;
								canvas.height = height;
								context.drawImage(img, (0), (0));
							}
							document.getElementById('resultadoImagen').innerHTML = '<img class="imagenResult" src=""/>';
                            context = canvas.getContext("2d");
                        }
                        document.getElementById('infoMatch').innerHTML = '<label class="positionNombreCenter">Mario Lagunes Nava, 22 years old.</label>';
                        ponBotones();
                    }
                }
            }

        </script>
        <script>
            function cargarMatch(valor) {
                if (valor == 'minutiaOriginal') {
                    document.getElementById('resultadoImagen').innerHTML = '<img class="imagenResult" src="' + src + '"/>';
                    document.getElementById('infoMatch').innerHTML = '<label class="positionNombreCenter"> </label>';
                    ponBotonesDisabled();
                }
                else if (valor == 'optionOne') {
                    document.getElementById('resultadoImagen').innerHTML = '<img class="imagenResult" src="../imgs/minutiaMatch.png"/>';
                    document.getElementById('infoMatch').innerHTML = '<label class="positionNombreCenter">Mario Lagunes Nava, 22 years old.</label>';
                    ponBotones();

                }
                else if (valor == 'optionTwo') {
                    document.getElementById('resultadoImagen').innerHTML = '<img class="imagenResult" src="../imgs/minutiaDefault.png"/>';
                    document.getElementById('infoMatch').innerHTML = '<label class="positionNombreCenter">Luis Daniel Rivero Sosa, 22 years old.</label>';
                    ponBotones();
                }
                else if (valor == 'optionThree') {
                    document.getElementById('resultadoImagen').innerHTML = '<img class="imagenResult" src="../imgs/minutiaMatch.png"/>';
                    document.getElementById('infoMatch').innerHTML = '<label class="positionNombreCenter">Fabiola Gómez Peña, 21 years old.</label>';
                    ponBotones();
                }
                else if (valor == 'optionFour') {
                    document.getElementById('resultadoImagen').innerHTML = '<img class="imagenResult" src="../imgs/minutiaDefault.png"/>';
                    document.getElementById('infoMatch').innerHTML = '<label class="positionNombreCenter">Yedith Jou Lamberstone Peréz, 20 years old</label>';
                    ponBotones();
                }
                else if (valor == 'select...') {
                    document.getElementById('resultadoImagen').innerHTML = '<img class="imagenResult""/>';
                    document.getElementById('infoMatch').innerHTML = '<label class="positionNombreCenter"></label>';
                    ponBotonesDisabled();
                }

            }

            function ponBotones() {
                var but = document.getElementById("hazMatch");
                but.disabled = false;
            }

            function ponBotonesDisabled() {
                var but = document.getElementById('hazMatch');
                but.disabled = true;
            }

            function quieresMatch() {
                answer = confirm("Do you want to match the prints?");
                if (answer != 0) {
                    alert("Prints succesfully matched!");
                    location = "../Pages/LatentModule.html";

                }
                else {
                    alert("Prints not matched!");
                }
            }
        </script>
    </form>
</body>
</html>

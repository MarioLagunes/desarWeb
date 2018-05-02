<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintVerification.aspx.cs" Inherits="LatentIdentifcation.PrintVerification" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Latent Module</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link href="../Pages/styleResponsive.css" rel="stylesheet" type="text/css" />
    
    <link rel="stylesheet" type="text/css" href="../Content/bootstrap.min.css" />
    <script type="text/javascript" src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
</head>
<body onload="crearCanvas()">

    <div class="topnav" id="myTopNav">
        <a href="../Pages/home.html" class="active"><img class="imagen" src="../imgs/home.png" /> Home</a>
        <div class="dropdown">
            <button class="dropbtn">
                <img class="imagen" src="../imgs/fingerPrint.png" />Modules
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
        <div>
            <div class="col-6"><label class="positionLabel" for="region">Region:</label></div>
            <div class="col-6">
                <select class="positionOptions" id="region" name="region" required="required">
                    <option value="--" selected="selected">--</option>
                    <option value="thumb">Thumb</option>
                    <option value="index">Index</option>
                    <option value="middle">Middle</option>
                    <option value="ring">Ring</option>
                    <option value="pincky">Pincky</option>
                    <option value="palm">Palm</option>
                    <option value="unknown">Unknown</option>
                </select>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-6"><label class="positionLabelSide" for="side">Side:</label></div>
        <div class="col-6">
            <select class="positionSide" id="side" name="side" required="required" disabled="disabled">
                <option value="--" selected="selected">--</option>
                <option value="right">Right</option>
                <option value="left">Left</option>
                <option value="both">Both</option>
            </select>
        </div>
    </div>
    <div class="row">
        <div class="col-12" id="lienzo"></div>
    </div>
    <div class="row">
        <div class="col-12">
            <input class="styleInput" id="inputFile1" type="file" disabled="disabled" />
        </div>
    </div>
    <div class="row">
        <div class="col-6">
            <button class="styleInputCon" id="btnContinue" disabled="disabled" onclick="validacionDatos()">Validar</button>
        </div>
        <div class="col-6">
            <button class="styleInputCan" id="btnCancel" disabled="disabled" onclick="location.href='PrintVerification.aspx'">Cancel</button>
        </div>
    </div>
    <div class="row">
        <div class="col-6">
            <button class="styleInputCon" id="btnContinuePlease" disabled="disabled" Visible="false">Continue</button>
        </div>
    </div>
    <script>

        var selectedOption;
        var selectedSide;
        var variables;
        function crearCanvas() {
             var canvasDiv = document.getElementById("lienzo");
             canvas = document.createElement('canvas');
             canvas.setAttribute('id', 'canvas');
             canvas.setAttribute('class', "styleInputImg");
             canvasDiv.appendChild(canvas);
             if (typeof G_vmlCanvasManager != 'undefined') {
                 canvas = G_vmlCanvasManager.initElement(canvas);
             }
             context = canvas.getContext("2d");
             var region = document.getElementById('region');
             var side = document.getElementById('side');
             region.addEventListener('change',
                 function () { 
                    selectedOption = this.options[region.selectedIndex];
                    side.disabled = false;
                 });
             side.addEventListener('change', function () {
                    selectedSide = this.options[side.selectedIndex];
                    inputFile.disabled = false;
             });
         }

         function myFuncion(imagenRuta) {
             var cadena = imagenRuta;
             $.post("/Home/Nombre", { texto: cadena }, function () { alert('imagen Cargada') });
         }

         var posx;
         var posy;
         var posix;
         var posiy;
         var isAngle = false;
         var arrayX = [];
         var arrayY = [];
         var lisX = [];
         var lisY = [];
         var borrar = false;
         var cont = 0;
         var inputFile = document.getElementById('inputFile1');
         var ultimax = 0;
         var ultimay = 0;
         var posx;
         var posy;
         var src;
         var codigo;
         var listX1 = [];
         var listY1 = [];
         var listX2 = [];
         var listY2 = [];
         var img = new Image();
         var width = 0;
         var height = 0;
         var btnCancel;
         var btnAccept;
         var btnContinuePlease;
         var srcImagenCargada;

         function init() {
             inputFile.addEventListener('change', mostrarImagen, false);
         }

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

         function mostrarImagen(event) {
             canvas.style.display = "block";
             document.getElementById("canvas").style.overflowY = "hidden";
             var urls = "";
             var ctx = context;
             if (ctx) {
                 var file = event.target.files[0];
                 var reader = new FileReader();
                 codigo = "hola";
                 reader.onload = function (event) {
                     img.src = event.target.result;
                     srcImagenCargada = event.target.result;
                 }
                 reader.readAsDataURL(file);
                 img.onload = function () {
                     if (document.getElementById("lienzo").offsetWidth < img.width) {
                         var width = document.getElementById("lienzo").offsetWidth;
                         var diferenciaEnX = document.getElementById("lienzo").offsetWidth / img.width;
                         var height = img.height * diferenciaEnX;
                         img.setAttribute('class', 'styleInputImg');
                         myFuncion(this.src);
                         codigo = "a";
                         canvas.setAttribute("width", width);
                         canvas.setAttribute("height", height);
                         canvas.setAttribute('class', 'styleInputImg');
                         context = canvas.getContext("2d");
                         ctx = context;
                         drawImageProp(ctx, img, 0, 0, document.getElementById("canvas").offsetWidth, document.getElementById("canvas").offsetHeight, -1, -1);
                     }
                     else {
                         var codigos = this.src;
                         myFuncion(this.src);
                         width = this.width;
                         height = this.height;
                         canvas.width = width;
                         canvas.height = height;
                         ctx.drawImage(img, (0), (0));
                     }
                 }
                 canvas.setAttribute("onclick", "draw(event)");
                 inputFile.style.display = 'none';
                 btnCancel = document.getElementById('btnCancel');
                 btnAccept = document.getElementById('btnContinue');
                 btnCancel.disabled = false;
                 btnAccept.disabled = false;
                 //btnAccept.setAttribute("onclick", validacionDatos());
                 //btnCancel.setAttribute("onclick", "location.href='PrintVerification.aspx'");
             }
         }

         function pasarVariables() {
                 var pagina = '../Pages/LatentResult.html';
                 pagina += '?';
                 variables = selectedOption.value + "," + selectedSide.value + "," + listX1 + "," + listX2 + "," + listY1 + "," + listY2;
                 nomVec = variables.split(",");
                 for (i = 0; i < nomVec.length; i++) {
                     pagina += "x" + [i] + "=" + nomVec[i] + "&";
                 }
                 pagina = pagina.substring(0, pagina.length - 1);
                 var enc = encodeURI(pagina);
                 console.log(pagina);
                 return enc;
         }

         window.addEventListener('load', init, false);

         var raiz = "C:\Users\Mario Prueba\Documents\Mis cosas\Tecnológico de Monterrey\8vo Semestre\Desarrollo web\DesaProyecto\LatentIdentifcation\LatentIdentifcation";

         function mostrarImagenDos() {
             canvas.style.display = "block";
             document.getElementById("canvas").style.overflowY = "hidden";
             var ctx = context;
             if (ctx) {
                 var img = new Image();
                 img.src = srcImagenCargada;
                 img.onload = function () {
                     if (document.getElementById("lienzo").offsetWidth < img.width) {
                         var width = document.getElementById("lienzo").offsetWidth;
                         var diferenciaEnX = document.getElementById("lienzo").offsetWidth / img.width;
                         var height = img.height * diferenciaEnX;
                         img.setAttribute('class', 'styleInputImg');
                         src = this.src;
                         canvas.setAttribute("width", width);
                         canvas.setAttribute("height", height);
                         canvas.setAttribute('class', 'styleInputImg');
                         context = canvas.getContext("2d");
                         ctx = context;
                         drawImageProp(ctx, img, 0, 0, document.getElementById("canvas").offsetWidth, document.getElementById("canvas").offsetHeight, -1, -1);
                     }
                     else {
                         ctx.drawImage(img, (0), (0));
                     }
                     dibujarMinutias();
                 }
             }
         }

         function existente(x, y) {
             var bandera = false; //bandera que si llega a ser true, indicará que se borró almenos una minutia
             //ciclo que borra de las listas las minutias seleccionadas con el cursor
             for (var i = 0; i < listX1.length; i++) {
                 if (x < listX1[i] + 6 && x > listX1[i] - 6) {
                     if (y < listY1[i] + 6 && y > listY1[i] - 6) {
                         //elimina la minutia del indice si es que se toco con el cursor
                         listX1.splice(i, 1);
                         listX2.splice(i, 1);
                         listY1.splice(i, 1);
                         listY2.splice(i, 1);
                         bandera = true;
                         i--;
                     }
                 }
             }
             if (bandera) {
                 limpiarCanvas();
                 mostrarImagenDos();
             }
             return bandera;
         }

         //dibuja todas las minutias que se encuentran en las listas
         function dibujarMinutias() {
             for (var i = 0; i < listX1.length; i++) {
                 //dibujar circulos:
                 context.fillStyle = 'rgba(255, 0, 0, 0.1)';
                 context.strokeStyle = 'rgba(255, 0, 0, 1)';
                 context.lineWidth = 3;
                 context.beginPath();
                 context.arc(listX1[i], listY1[i], 6, 0, 2 * Math.PI);
                 context.fill();
                 context.stroke();
                 //dibujar lineas
                 context.lineWidth = 3;
                 context.strokeStyle = "#f00";
                 context.beginPath();
                 context.moveTo(listX1[i], listY1[i]);
                 context.lineTo(listX2[i], listY2[i]);
                 context.stroke();
             }
         }

         function draw(e) {
             if (!isAngle) {
                 var pos = getMousePos(canvas, e);
                 if (!existente(pos.x, pos.y)) {
                     console.log("dibujo circulo en " + pos.x + " " + pos.y);
                     posx = pos.x;
                     ultimax = posx;
                     posy = pos.y;
                     ultimay = pos.y;
                     context.fillStyle = 'rgba(255, 0, 0, 0.1)';
                     context.strokeStyle = 'rgba(255, 0, 0, 1)';
                     context.lineWidth = 3;
                     context.beginPath();
                     //dubuja el circulo con radio 6
                     context.arc(posx, posy, 6, 0, 2 * Math.PI);
                     context.fill();
                     context.stroke();
                     //activa la bandera para que en el proximo toque haga la linea
                     isAngle = true;
                 }
             }
             else {
                 var pos = getMousePos(canvas, e);
                 context.lineWidth = 3;
                 context.strokeStyle = "#f00";
                 context.beginPath();
                 //empieza la linea con este punto
                 context.moveTo(ultimax, ultimay);
                 x1 = ultimax;
                 y1 = ultimay;
                 x2 = pos.x;
                 y2 = pos.y;
                 var puntoDimensionado = PD(x1, y1, x2, y2, 50);
                 x2 = x1 + puntoDimensionado.com;
                 y2 = y1 + puntoDimensionado.cam;
                 //dibuja la linea teniendo en mente la nueva linea de largo H
                 context.lineTo(x2, y2);
                 context.stroke();
                 isAngle = false;//desactiva la bandera para que en la siguiente iteracion dibuje mas circulos
                 //guardar las variables en listas
                 listX1.push(x1);
                 listY1.push(y1);
                 listX2.push(x2);
                 listY2.push(y2);
             }
         }
         function validacionDatos() {
             if (selectedOption.value == "--") {
                 alert("Change the value of region!");
             }
             else if (selectedSide.value == "--") {
                 alert("Change the value of Side");
             }
             else if (selectedOption.value == "--" && selectedSide.value == "--") {
                 alert("Change the value of Region and Side");
             }
             else if (listX1.length == 0) {
                 alert("Draw at least one minutia");
             }
             else {
                 var regionCmbs = document.getElementById("region");
                 var sideCmbs = document.getElementById("side");
                 btnContinuePlease = document.getElementById("btnContinuePlease");
                 btnContinuePlease.disabled = false;
                 btnAccept.disabled = true;
                 regionCmbs.disabled = true;
                 sideCmbs.disabled = true;
                 var nuevaPag = pasarVariables();
                 console.log("hola Mario: " + nuevaPag);
                 btnContinuePlease.setAttribute("onclick", "location.href='" + nuevaPag + "'");
             }
             
         }
         //borra el canvas por completo
         function limpiarCanvas() {
             context.clearRect(0, 0, canvas.width, canvas.height);
         }
         //calcula una linea de largo H, teniendo en cuenta dos puntos
         function PD(x1, y1, x2, y2, H) {
             var ca;
             var co;
             var caMy;
             var coMy;
             //obtiene el cateto opuesto
             if (x2 > x1) {
                 co = x2 - x1;
             }
             else {
                 co = x1 - x2;
             }
             //obtiene el cateto adyacente
             if (y1 > y2) {
                 ca = y1 - y2;
             }
             else {
                 ca = y2 - y1;
             }
             //---------ANGULO(en radianes)-------------
             var angulo = Math.atan(co / ca);
             //obtiene los catetos con la hipotenusa especificada
             caMy = Math.cos(angulo) * H;
             coMy = Math.sin(angulo) * H;
             //ajusta el sentido de los nuevos catetos
             if (x2 < x1) {
                 coMy = coMy * -1;
             }
             if (y2 < y1) {
                 caMy = caMy * -1;
             }
             //regresa los nuevos catetos
             return {
                 com: coMy,
                 cam: caMy
             };
         }
         //conviarte de radianes a grados
         function toDegrees(angle) {
             return angle * (180 / Math.PI);
         }

         function getMousePos(canvas, evt) {
             var rect = canvas.getBoundingClientRect();

             return {
                 x: evt.clientX - rect.left,
                 y: evt.clientY - rect.top
             };

         }
         window.draw = draw;
    </script>
</body>
</html>

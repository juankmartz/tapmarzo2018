/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function envioFormularioServlet(formulario, idContRespuesta, remplazarContenido) {
    mostrarLoaderOndaDeCubos('Procesando...');
    $.ajax({
        url: $(formulario).attr("action"),
        type: "post",
        dataType: "html",
        data: $(formulario).serialize(),
        cache: false,
        processData: false,
        success: function (result) {
            if (remplazarContenido) {
                $("#" + idContRespuesta).html(result);
            } else {
                $("#" + idContRespuesta).append(result);
            }
            ocultarLoaderOndaDeCubos();
        },
        error: function () {
            ocultarLoaderOndaDeCubos();
            nuevaNotify('error', 'Error', 'Ha ocurrido un error en el envio del formulario; intentelo mas tarde', 9000);
        }
    });
}


function evioFormulario(formulario) {
    mostrarLoaderOndaDeCubos('Procesando...');
    $.ajax({
        url: $(formulario).attr("action"),
        type: "post",
        dataType: "html",
        data: $(formulario).serialize(),
        cache: false,
//                contentType: false,
        processData: false,
        success: function (result) {
            $("#contenedorPagina").html(result);
            ocultarLoaderOndaDeCubos();
        },
        error: function () {
            ocultarLoaderOndaDeCubos();
            nuevaNotify('error', 'Error', 'Ha ocurrido un error en el envio del formulario; intentelo mas tarde', 9000);
        }
    });
}

function evioFormularioServlet(formulario, idContRespuesta, remplazarContenido) {
    mostrarLoaderOndaDeCubos('Procesando...');
    $.ajax({
        url: $(formulario).attr("action"),
        type: "post",
        dataType: "html",
        data: $(formulario).serialize(),
        cache: false,
        processData: false,
        success: function (result) {
            if (remplazarContenido) {
                $("#" + idContRespuesta).html(result);
            } else {
                $("#" + idContRespuesta).append(result);
            }
            ocultarLoaderOndaDeCubos();
        },
        error: function () {
            ocultarLoaderOndaDeCubos();
            nuevaNotify('error', 'Error', 'Ha ocurrido un error en el envio del formulario; intentelo mas tarde', 9000);
        }
    });
}

function cargarPaguinaAjax(ruta, idContPag, remplazarContenido) {
    mostrarLoaderOndaDeCubos('Cargando...');
    $.ajax({
        url: ruta,
        type: "post",
        dataType: "html",
        cache: false,
//                contentType: false,
        processData: false,
        success: function (result) {
            if (remplazarContenido) {
                $("#" + idContPag).html(result);
            } else {
                $("#" + idContPag).append(result);
            }
            ocultarLoaderOndaDeCubos();
        },
        error: function () {
            ocultarLoaderOndaDeCubos();
            nuevaNotify('error', 'Error', 'No fjue posible cargar el recurso solicitado; intentelo mas tarde', 10000);
        }
    });
}


function envioFormularioFile(formulario)
{
    mostrarLoaderOndaDeCubos("Procesando archivo")
    var formData = new FormData(formulario);

    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: $(formulario).attr("action"),
        dataType: "html",
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function (data) {
            $(formulario).append(data);
            ocultarLoaderOndaDeCubos();
        }
    });
}
function mostrarLoaderOndaDeCubos(texto) {
    $("#loaderArchitic").css("display", "flex");
    $(".cssload-spinner").children("h3").text(texto);
}
function ocultarLoaderOndaDeCubos() {
    $("#loaderArchitic").css("display", "none");
}
function iniLoaderOndaDeCubos(texto) {
//if (texto == '') texto = 'Cargando...';
    $('#loaderArchitic').html(
            '<div class="cssload-spinner">' +
            '<div class="cssload-cube cssload-cube0"></div>' +
            '<div class="cssload-cube cssload-cube1"></div>' +
            '<div class="cssload-cube cssload-cube2"></div>' +
            '<div class="cssload-cube cssload-cube3"></div>' +
            '<div class="cssload-cube cssload-cube4"></div>' +
            '<div class="cssload-cube cssload-cube5"></div>' +
            '<div class="cssload-cube cssload-cube6"></div>' +
            '<div class="cssload-cube cssload-cube7"></div>' +
            '<div class="cssload-cube cssload-cube8"></div>' +
            '<div class="cssload-cube cssload-cube9"></div>' +
            '<div class="cssload-cube cssload-cube10"></div>' +
            '<div class="cssload-cube cssload-cube11"></div>' +
            '<div class="cssload-cube cssload-cube12"></div>' +
            '<div class="cssload-cube cssload-cube13"></div>' +
            '<div class="cssload-cube cssload-cube14"></div>' +
            '<div class="cssload-cube cssload-cube15"></div>' +
            '<h3 id="txtLoader">' + texto + '</h3></div>');
    $('#loaderArchitic').css('display', '-webkit-flex');
    ocultarLoaderOndaDeCubos();
}

function setTextoLoader(text) {
    $("#txtLoader").html(text);
}
/*
 * notice, warning or error
 */
function nuevaNotify(tipo, titulo, mensaje, tiempo) {
    var notification = new NotificationFx({
        wrapper: document.getElementById('contenedorNotificacion'),
        message: '<h4><b>' + titulo + '</b></h4><p>' + mensaje + '</p>',
        layout: 'other',
        effect: 'boxspinner',
        ttl: tiempo,
        type: tipo, // notice, warning or error
        onClose: function () {
//            bttn.disabled = false;
        }
    });
    notification.show();
}
function iniPanelButon() {
    $(".collapse-link").on("click", function () {
        var a = $(this).closest(".x_panel"), b = $(this).find("i"), c = a.find(".x_content");
        a.attr("style") ? c.slideToggle(200, function () {
            a.removeAttr("style");
        }) : (c.slideToggle(200), a.css("height", "auto")), b.toggleClass("fa-chevron-up fa-chevron-down");
    }), $(".close-link").click(function () {
        var a = $(this).closest(".x_panel_Principal");
        a.remove();
    });
}
function iniPanelButon(tiempoAnimacion) {
    if (tiempoAnimacion == null)
        tiempoAnimacion = 300;
    $(".collapse-link").on("click", function () {
        var a = $(this).closest(".x_panel"), b = $(this).find("i"), c = a.find(".x_content");
        a.attr("style") ? c.slideToggle(200 + tiempoAnimacion, function () {
            a.removeAttr("style");
        }) : (c.slideToggle(tiempoAnimacion), a.css("height", "auto")), b.toggleClass("fa-chevron-up fa-chevron-down");
    }), $(".close-link").click(function () {
        var a = $(this).closest(".x_panel_Principal");
        a.remove();
    });
}

function cargarPagina(ruta) {
    mostrarLoaderOndaDeCubos('Cargando...');
    if (ruta == '') {
        ocultarLoaderOndaDeCubos();
        return false;
    } else
        $.ajax({
            url: ruta,
            success: function (result) {
                $("#contenedorPagina").html(result);
                ocultarLoaderOndaDeCubos();
            },
            error: function () {
                ocultarLoaderOndaDeCubos();
            }
        });
}

function agregarMenuHoverTabla(idtabla) {
    $("#" + idtabla + " tbody").find("tr").each(function () {

        $(this).hover(function () {
            var posicion = $(this).position();
//                                            var height = $(this).outerHeight(true);
            indexRow = $(this).index();
            Row = $(this);
            console.log("index: " + $(this).index() + ", left: " + posicion.left + ", top: " + posicion.top);
//            console.log($(this).index());
            var posicX = (6 + posicion.top) + "px";
//            var posicy = (-10 + posicion.left) + "px";
            var posicy = (-$(".menuHoverTabla").width() + $("#" + idtabla).width()) + "px";
            $(".menuHoverTabla").css("top", posicX);
            $(".menuHoverTabla").css("left", posicy);
            $(".menuHoverTabla").css("display", "block");
            $(".menuHoverTabla").on("click", function () {
//                                    var tabla = $.fn.dataTable.isDataTable( '#tablaResultado' );
                $(".menuHoverTabla").css("display", "none");
                $(Row).attr("class", "selected");
//                                   
                var table = $('#tablaResultado').DataTable();
//                                                var rows = table
//                                                        .rows('.selected')
//                                                        .remove()
//                                                        .draw();
            });
        });
    });
}
function cerrarSession()
{
    mostrarLoaderOndaDeCubos("Saliendo...");
    $.ajax(
            {
                url: "../miLogin",
                type: "post",
                dataType: "html",
                data: "oper=cerrarSession&",
                success: function (result) {
                    window.location.href = "../";
                },
                error: function () {
                    ocultarLoaderOndaDeCubos();
                    nuevaNotify('warning', 'Falla de session', 'Ha ocurrido un problema con el cierre de session', 7000);
                }
            }
    );
}


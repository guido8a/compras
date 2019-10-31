<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 9/2/13
  Time: 3:00 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta name="layout" content="main">
    %{--        <script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>--}%
    %{--        <link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">--}%

    %{--        <asset:javascript src="/apli/jquery.luz.box.js"/>--}%
    %{--        <asset:stylesheet src="/apli/jquery.luz.box.css"/>--}%

    <title>Días laborables</title>

    <style type="text/css">
    div.mes {
        float  : left;
        margin : 0 0 10px 10px;
        height : 185px;
    }

    table.mes {
        border-collapse : collapse;
    }

    .dia {
        width      : 38px;
        text-align : center;
        cursor     : pointer;
    }

    .vacio {
        background-color : #AAAAAA;
    }

    .vacacion {
        background-color : #5CAACE;
    }

    h1 {
        text-align : center;
    }

    .demo {
        width      : 20px;
        height     : 20px;
        text-align : center;
        display    : inline-block;
    }

    .nombreMes {
        font-size : 18px;
    }
    </style>
</head>

<body>

<h1>
    <g:link controller="parametros" action="list" class="btn btn-info" style="float: left">
        <i class="fa fa-arrow-left"></i> Parámetros
    </g:link>
%{--            Año <g:select style="font-size:large;" name="anio" class="input-small" from="${anio - 5..anio + 5}" value="${params.anio}"/>--}%
    Año <g:select style="font-size:large;" name="anio" class="input-small" from="${listaAnios}" optionKey="anio" optionValue="anio" value="${params.anio}"/>
    <a href="#" class="btn btn-primary" id="btnCambiar"><i class="fa fa-sync-alt"></i> Cambiar</a>
    <a href="#" class="btn btn-success" id="btnGuardar"><i class="fa fa-save"></i> Guardar</a>
    <a href="#" class="btn btn-warning" id="btnCrearAnio"><i class="fa fa-clock"></i> Crear Año</a>
</h1>

<div class="well" style="font-size: 14px">
    Los días marcados con <div class="demo vacacion" style="text-align: center"> </div> son <strong>no</strong> laborables. <br/>
    Para cambiar el estado de un día haga clic sobre el mismo.<br/>
    Los cambios se guardarán únicamente haciendo clic en el botón <i class="fa fa-save text-success"></i> Guardar.
</div>

<g:set var="mesAct" value="${null}"/>
<g:each in="${dias}" var="dia" status="i">
    <g:set var="mes" value="${meses[dia.fecha.format('MM').toInteger()]}"/>
    <g:set var="dia" value="${meses[dia.fecha.format('MM').toInteger()]}"/>
    <g:if test="${mes != mesAct}">
        <g:if test="${mesAct}">
            </table>
            </div>
        </g:if>
        <g:set var="mesAct" value="${mes}"/>
        <g:set var="num" value="${1}"/>
        <div class="mes">
        <table class="mes" border="1">
        <thead>
        <tr>
        <th class="nombreMes" colspan="7">${mesAct}</th>
                </tr>
        <tr>
            <th>Lun</th>
            <th>Mar</th>
            <th>Mié</th>
            <th>Jue</th>
            <th>Vie</th>
            <th>Sáb</th>
            <th>Dom</th>
        </tr>
        </thead>
    </g:if>
    <g:if test="${num % 7 == 1}">
        <tr>
    </g:if>
    <g:if test="${dia.fecha.format("dd").toInteger() == 1}">
        <g:if test="${dia.dia.toInteger() != 1}">%{--No empieza en lunes: hay q dibujar celdas vacias en los dias necesarios--}%
            <g:each in="${1..(dia.dia.toInteger() - 1 + (dia.dia.toInteger() > 0 ? 0 : 7))}" var="extra">
                <td class="vacio"></td>
                <g:set var="num" value="${num + 1}"/>
            </g:each>
        </g:if>
    </g:if>

%{--            <td class="dia ${dia.ordinal == 0 ? 'vacacion' : ''}" data-fecha="${dia.fecha.format('dd-MM-yyyy')}" data-id="${dia.id}" title="${dia.fecha.format('dd-MM-yyyy')}">--}%
    <td class="dia ${dia.ordinal == 0 ? 'vacacion' : ''}" data-fecha="${dia.fecha.format('dd-MM-yyyy')}" data-id="${dia.id}">
        ${dia.fecha.format("dd")}
    </td>

    <g:set var="num" value="${num + 1}"/>

    <g:if test="${i == dias.size() - 1 || (i < dias.size() - 1) && (meses[dias[i + 1].fecha.format('MM').toInteger()] != mesAct)}">
        <g:if test="${dia.dia.toInteger() != 0}">
            <g:each in="${1..7 - (num % 7 > 0 ? num % 7 : 7) + 1}" var="extra">
                <td class="vacio"></td>
            </g:each>
        </g:if>
    </g:if>
</g:each>
%{--    </table>--}%
%{--    </div>--}%

<script type="application/javascript">

    $("#btnCrearAnio").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'anio', action: 'form_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgAnio",
                    title : "Año",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                guardarAnio($("#anioId").val());
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    function  guardarAnio(anio){
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'anio', action: 'save')}',
            data:{
                anio:anio
            },
            success: function (msg) {
                var parts = msg.split("_");
                if(parts[0] == 'ok'){
                    log("Año guardado correctamente", "success");
                    setTimeout(function () {
                        location.reload(true);
                    }, 1000);
                }else{
                    if(parts[0] == 'er'){
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }else{
                        log("Error al guardar el año","error");
                    }

                }
            }
        });
    }


    $(function () {
        $('.dia').tooltip()
            .click(function () {
                $(this).toggleClass("vacacion");
            });
        $("#anio").val("${params.anio}");
        $("#btnCambiar").click(function () {
            var anio = $("#anio").val();
            if ("" + anio != "${params.anio}") {
                location.href = "${createLink(action: 'calendario')}?anio=" + anio;
            }
            return false;
        });
        $("#btnGuardar").click(function () {
            var dialog = cargarLoader("Guardando...");
            var cont = 1;
            var data = "";
            $(".dia").each(function () {
                var $dia = $(this);
                var fecha = $dia.data("fecha");
                var id = $dia.data("id");
                var laborable = !$dia.hasClass("vacacion");
                if (data != "") {
                    data += "&";
                }
                data += "dia=" + id + ":" + fecha + ":";
                if (laborable) {
                    data += cont;
                    cont++;
                } else {
                    data += "0";
                }
            });
            $.ajax({
                type    : "POST",
                url     : "${createLink(action: 'saveCalendario')}",
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    if (msg == "OK") {
                        log("Calendario guardado correctamente","success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 1000);
                    } else {
                        log("Error al guardar el calendario","error")
                    }
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
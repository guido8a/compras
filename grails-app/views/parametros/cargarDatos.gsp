<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 10/10/19
  Time: 13:12
--%>


<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Cargar Datos</title>

%{--    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/vendor', file: 'jquery.ui.widget.js')}"></script>--}%
%{--    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/imgResize', file: 'load-image.min.js')}"></script>--}%
%{--    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/imgResize', file: 'canvas-to-blob.min.js')}"></script>--}%
%{--    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.iframe-transport.js')}"></script>--}%
%{--    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload.js')}"></script>--}%
%{--    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload-process.js')}"></script>--}%
%{--    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload-image.js')}"></script>--}%
%{--    <link href="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/css', file: 'jquery.fileupload.css')}"--}%
%{--          rel="stylesheet">--}%

    <asset:javascript src="/jQuery-File-Upload-9.5.6/js/vendor/jquery.ui.widget.js"/>
    <asset:javascript src="/jQuery-File-Upload-9.5.6/js/jquery.iframe-transport.js"/>
    <asset:javascript src="/jQuery-File-Upload-9.5.6/js/jquery.fileupload.js"/>
    <asset:javascript src="/jQuery-File-Upload-9.5.6/js/jquery.fileupload-process.js"/>



    <style type="text/css">

    .alinear {
        text-align: center !important;
    }

    #buscar {
        width: 400px;
        border-color: #0c6cc2;
    }
    </style>

</head>

<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="parametros" action="list" class="btn btn-info">
            <i class="fa fa-arrow-left"></i> Parámetros
        </g:link>
    </div>
    <div class="btn-group">
        <a href="#" class="btn col-md-12 btn-success" id="cargarDatos"><i class="fa fa-file-excel"></i>
            Cargar datos
        </a>
    </div>
</div>

<div class="col-md-6" style="margin-top: 10px">
    <g:uploadForm action="validar" method="post" name="frmaArchivo">
        <div class="panel panel-primary">
            <div class="panel-heading">Seleccionar el archivo a cargar</div>

            <div class="panel-body">

                <div class="panel-body col-md-2">
                    <label>Archivo</label>
                </div>

                <span class="btn btn-info fileinput-button col-md-8" style="position: relative">
                    <input type="file" name="file" multiple="" id="archivo" class="archivo col-md-12">
                    <input type="hidden" name="tipoTabla" id="tipoTabla" value="">
                </span>
                <div class="col-md-1"></div>
                <div class="col-md-4" id="spinner">
                </div>
            </div>
        </div>
    </g:uploadForm>
</div>


<script type="text/javascript">
    $("#cargarDatos").click(function () {
        if($("#archivo").val()!=""){
            $("#tipoTabla").val($("#tabla").val());
            var dialog = cargarLoader("Cargando...");
            $("#frmaArchivo").submit();
        }else{
            bootbox.alert("No ha ingresado ningún archivo para ser cargado")
        }
    });

</script>


</body>
</html>

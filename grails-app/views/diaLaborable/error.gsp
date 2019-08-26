<%@ page import="utilitarios.Anio" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Cerrar año</title>
    </head>

    <body>
        <elm:flashMessage tipo="error" contenido="${flash.message}"/>
        <util:renderHTML html="${js}"/>

%{--    <div class="alert alert-danger col-md-6" style="text-align: center; font-size: 14px">--}%
%{--        <p><i class='fa fa-power-off fa-3x pull-left text-shadow'></i>¿Está seguro que desea cerrar el año de proceso: ${anio?.numero ?: ''}?</p>--}%
%{--        <p style="margin-bottom: 15px"> Esta acción no se puede deshacer.</p>--}%

%{--        <a href="#" class="btn btn-danger" id="btnCerrar" ><i class="fa fa-power-off"></i> Desactivar </a>--}%
%{--    </div>--}%

%{--    <script type="text/javascript">--}%

%{--        $("#btnCerrar").click(function () {--}%
%{--            location.href = "${createLink(controller: 'diaLaborable', action: 'desactivar')}/${anio?.id}";--}%
%{--        });--}%

%{--    </script>--}%

    </body>
</html>
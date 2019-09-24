%{--<%@ page import="compras.Item" %>--}%

<form class="form-horizontal">


    <form class="form-horizontal">
        <g:if test="${itemInstance?.nombre}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">DESCRIPCIÓN</td>
                        <td style="width: 65%" class="alert-success">${itemInstance?.nombre}</td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.codigo}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">CÓDIGO</td>
%{--                        <td style="width: 65%" class="alert-success"> ${itemInstance?.departamento?.subgrupo?.codigo?.toString()?.padLeft(3,'0')}.${itemInstance?.departamento?.codigo?.toString()?.padLeft(3,'0')}.${itemInstance?.codigo?.toString()?.padLeft(3,'0')}</td>--}%
                        <td style="width: 65%" class="alert-success"> ${itemInstance?.codigo?.toString()?.padLeft(3,'0')}</td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.unidad}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">UNIDAD</td>
                        <td style="width: 65%" class="alert-success"> ${itemInstance?.unidad?.descripcion}</td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.departamento}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">SUBGRUPO</td>
                        <td style="width: 65%" class="alert-success"> ${itemInstance?.departamento?.descripcion}</td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance.departamento.subgrupo.grupo.id.toString() == '1'}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning"> ${(itemInstance?.tipoLista?.codigo[0] == 'P') ? 'PESO' : 'VOLUMEN'}</td>
                        <td style="width: 65%" class="alert-success">  <g:formatNumber number="${itemInstance.peso}" maxFractionDigits="6" minFractionDigits="6" format='##,######0' locale='ec'/></td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.estado}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">ESTADO</td>
                        <td style="width: 65%" class="alert-success">  ${itemInstance.estado == 'A' ? 'ACTIVO' : itemInstance.estado == 'B' ? 'DADO DE BAJA' : ''}</td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.fecha}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">FECHA DE CREACIÓN</td>
                        <td style="width: 65%" class="alert-success">  <g:formatDate date="${itemInstance?.fecha}" format="dd-MM-yyyy"/></td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.fecha}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">FECHA ÚLTIMA MODIFICACIÓN</td>
                        <td style="width: 65%" class="alert-success">  <g:formatDate date="${itemInstance?.fechaModificacion}" format="dd-MM-yyyy"/></td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.codigoComprasPublicas}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">CÓDIGO CPC</td>
                        <td style="width: 65%" class="alert-success"> ${itemInstance?.codigoComprasPublicas?.numero} - ${itemInstance?.codigoComprasPublicas?.descripcion} </td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.transportePeso}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">TRANSPORTE PESO</td>
                        <td style="width: 65%" class="alert-success"> ${itemInstance?.transportePeso} </td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.transporteVolumen}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">TRANSPORTE VOLUMEN</td>
                        <td style="width: 65%" class="alert-success"> ${itemInstance?.transporteVolumen} </td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.rendimiento}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">RENDIMIENTO</td>
                        <td style="width: 65%" class="alert-success"> ${itemInstance?.rendimiento} </td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.tipo}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">TIPO</td>
                        <td style="width: 65%" class="alert-success"> ${itemInstance?.tipo} </td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.registro}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">REGISTRO</td>
                        <td style="width: 65%" class="alert-success"> ${itemInstance.registro == 'N' ? 'NO REGISTRADO' : 'REGISTRADO'} </td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${itemInstance?.observaciones}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">OBSERVACIONES</td>
                        <td style="width: 65%" class="alert-success"> ${itemInstance.observaciones} </td>
                    </tr>
                </table>
            </div>
        </g:if>
    </form>



%{--    <g:if test="${itemInstance?.transporte}">--}%
%{--        <div class="control-group">--}%
%{--            <div>--}%
%{--                <span id="transporte-label" class="control-label label label-inverse">--}%
%{--                    Transporte--}%
%{--                </span>--}%
%{--            </div>--}%

%{--            <div class="controls">--}%

%{--                <span aria-labelledby="transporte-label">--}%
%{--                    ${(itemInstance.transporte == 'P') ? 'PESO' : itemInstance.transporte == 'V' ? 'VOLUMEN' : ''}--}%
%{--                    <g:if test="${itemInstance.transporte == 'P'}">--}%
%{--                        Peso (capital de cantón)--}%
%{--                    </g:if>--}%
%{--                    <g:elseif test="${itemInstance.transporte == 'P1'}">--}%
%{--                        Peso (especial)--}%
%{--                    </g:elseif>--}%
%{--                    <g:elseif test="${itemInstance.transporte == 'V'}">--}%
%{--                        Volumen (materiales pétreos para hormigones)--}%
%{--                    </g:elseif>--}%
%{--                    <g:elseif test="${itemInstance.transporte == 'V1'}">--}%
%{--                        Volumen (materiales pétreos para mejoramiento)--}%
%{--                    </g:elseif>--}%
%{--                    <g:elseif test="${itemInstance.transporte == 'V2'}">--}%
%{--                        Volumen (materiales pétreos para carpeta asfáltica)--}%
%{--                    </g:elseif>--}%

%{--                </span>--}%

%{--            </div>--}%
%{--        </div>--}%
%{--    </g:if>--}%

%{--    <g:if test="${itemInstance?.combustible}">--}%
%{--        <div class="control-group">--}%
%{--            <div>--}%
%{--                <span id="combustible-label" class="control-label label label-inverse">--}%
%{--                    Combustible--}%
%{--                </span>--}%
%{--            </div>--}%

%{--            <div class="controls">--}%

%{--                <span aria-labelledby="combustible-label">--}%
%{--                    ${itemInstance.combustible == 'S' ? 'SI' : itemInstance.combustible == 'N' ? 'NO' : ''}--}%
%{--                </span>--}%

%{--            </div>--}%
%{--        </div>--}%
%{--    </g:if>--}%

%{--    <g:if test="${itemInstance?.observaciones}">--}%
%{--        <div class="control-group">--}%
%{--            <div>--}%
%{--                <span id="observaciones-label" class="control-label label label-inverse">--}%
%{--                    Observaciones--}%
%{--                </span>--}%
%{--            </div>--}%

%{--            <div class="controls">--}%

%{--                <span aria-labelledby="observaciones-label">--}%
%{--                    <g:fieldValue bean="${itemInstance}" field="observaciones"/>--}%
%{--                </span>--}%

%{--            </div>--}%
%{--        </div>--}%
%{--    </g:if>--}%

</form>

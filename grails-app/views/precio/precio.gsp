<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 24/12/19
  Time: 10:43
--%>



<div style="margin-top: 15px; min-height: 250px" class="vertical-container">
    <p class="css-vertical-text">Detalles</p>
    <div class="linea"></div>
    <div class="" style="margin-top: 0px">
        <a href="#" name="bpd" class="btnBuscarPrecio btn btn-warning" title="Buscar Precio"><i class="fa fa-search"></i> Agregar precio</a>
    </div>
    <table class="table table-bordered table-hover table-condensed" style="width: 70%; background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 10%">Precio U.</th>
            <th class="alinear" style="width: 25%">Proveedor</th>
            <th class="alinear" style="width: 20%">Descripcion</th>
            <th class="alinear" style="width: 10%">Fuente</th>
            <th class="alinear" style="width: 5%"></th>
        </tr>
        </thead>
    </table>
%{--    <div class="" style="width: 99.7%;height: 240px; overflow-y: auto;float: right; margin-top: -20px">--}%
%{--        <table class="table-bordered table-condensed table-hover" style="width: 70%">--}%
%{--            <g:each in="${lista}" var="detalle" status="z">--}%
%{--                <tr>--}%
%{--                    <td style="width: 10%; text-align: right">--}%
%{--                        ${detalle.value[1]}--}%
%{--                    </td>--}%
%{--                    <td style="width: 25%; text-align: left">--}%
%{--                        ${detalle.value[4]}--}%
%{--                    </td>--}%
%{--                    <td style="width: 20%;">--}%
%{--                        ${detalle.value[3]}--}%
%{--                    </td>--}%
%{--                    <td style="width: 10%; text-align: center; background-color: ${detalle.value[2] == 'Proforma' ? '#ffca87' : '#5596ff'}">--}%
%{--                        ${detalle.value[2]}--}%
%{--                    </td>--}%
%{--                    <td style="width: 5%; text-align: center">--}%
%{--                        <a href="#" class="btn btn-success btn-xs btnSeleccionarPrecio" title="Seleccionar precio" data-precio="${detalle.value[1]}" data-origen="${detalle.value[5]}" data-nombre="${detalle.value[2]}"><i class="fa fa-check"></i></a>--}%
%{--                    </td>--}%
%{--                </tr>--}%
%{--            </g:each>--}%
%{--        </table>--}%
%{--    </div>--}%
</div>


<div style="margin-top: 15px; min-height: 250px" class="vertical-container">
    <p class="css-vertical-text">Proformas</p>
    <div class="linea"></div>
    <div class="" style="margin-top: 0px">
        <a href="#" name="bpp" class="btnBuscarPrecio btn btn-warning" title="Buscar Precio"><i class="fa fa-search"></i> Agregar precio</a>
    </div>
    <table class="table table-bordered table-hover table-condensed" style="width: 70%; background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 10%">Precio U.</th>
            <th class="alinear" style="width: 25%">Proveedor</th>
            <th class="alinear" style="width: 20%">Descripcion</th>
            <th class="alinear" style="width: 10%">Fuente</th>
            <th class="alinear" style="width: 5%"></th>
        </tr>
        </thead>
    </table>
%{--    <div class="" style="width: 99.7%;height: 240px; overflow-y: auto;float: right; margin-top: -20px">--}%
%{--        <table class="table-bordered table-condensed table-hover" style="width: 100%">--}%
%{--            <g:each in="${lista}" var="detalle" status="z">--}%
%{--                <tr>--}%
%{--                    <td style="width: 10%; text-align: right">--}%
%{--                        --}%%{--                        ${detalle.value[1]}--}%
%{--                    </td>--}%
%{--                    <td style="width: 25%; text-align: left">--}%
%{--                        --}%%{--                        ${detalle.value[4]}--}%
%{--                    </td>--}%
%{--                    <td style="width: 20%;">--}%
%{--                        --}%%{--                        ${detalle.value[3]}--}%
%{--                    </td>--}%
%{--                    <td style="width: 10%; text-align: center; background-color: ${detalle.value[2] == 'Proforma' ? '#ffca87' : '#5596ff'}">--}%
%{--                        --}%%{--                        ${detalle.value[2]}--}%
%{--                    </td>--}%
%{--                    <td style="width: 5%; text-align: center">--}%
%{--                        --}%%{--                        <a href="#" class="btn btn-success btn-xs btnSeleccionarPrecio" title="Seleccionar precio" data-precio="${detalle.value[1]}" data-origen="${detalle.value[5]}" data-nombre="${detalle.value[2]}"><i class="fa fa-check"></i></a>--}%
%{--                    </td>--}%
%{--                </tr>--}%
%{--            </g:each>--}%
%{--        </table>--}%
%{--    </div>--}%
</div>
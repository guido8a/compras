<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 07/01/20
  Time: 10:55
--%>

<div class="row">
    <table>
        <tbody>
        <tr>
            <td>
                <div class="col-md-12">
                    <strong>Proformas</strong>
                    <g:if test="${tamanoProformas != 0}">
                        <table class="table table-bordered table-hover table-condensed col-md-12" style="width: 100%; text-align: center; font-size: 14px; font-weight: bold">
                            <tbody>
                            <tr style="background-color: #3cbcd9">
                                <g:each in="${valoresPf.values()}" var="valorPf">
                                    <td>${valorPf}</td>
                                </g:each>
                            </tr>
                            <tr>
                                <g:radioGroup name="precioProforma" onclick="guardarValorProforma()"
                                              values="${valoresPf}"
                                              labels="${etiquetas}"
                                              value="${detalle?.criterioProforma?.id + "=" + detalle?.precioProforma}">
                                    <p><td>${it.label} ${it.radio}</td></p>
                                </g:radioGroup>
                            </tr>
                            </tbody>
                        </table>
                    </g:if>
                    <g:else>
                        <br>* No existen valores seleccionados de Proformas  anteriores
                    </g:else>
                </div>

                <div class="col-md-12">
                    <strong>Detalles</strong>
                    <g:if test="${tamanoProyecto != 0}">
                        <table class="table table-bordered table-hover table-condensed col-md-12" style="width: 100%; text-align: center; font-size: 14px; font-weight: bold">
                            <tbody>
                            <tr style="background-color: #78b665">
                                <g:each in="${valoresPy.values()}" var="valorPy">
                                    <td>${valorPy}</td>
                                </g:each>
                            </tr>
                            <tr>
                                <g:radioGroup name="precioProyecto" onclick="guardarValorProyecto()"
                                              values="${valoresPy}"
                                              labels="${etiquetas}"
                                              value="${detalle?.criterioProyecto?.id + "="+ detalle?.precioProyecto}">
                                    <p><td>${it.label} ${it.radio}</td></p>
                                </g:radioGroup>
                            </tr>
                            </tbody>
                        </table>
                    </g:if>
                    <g:else>
                       <br>* No existen valores seleccionados de Proyectos anteriores
                    </g:else>
                </div>
            </td>
            <td>
                <div class="col-md-12">
                    <strong>Precio definitivo</strong>
                        <table class="table table-bordered table-hover table-condensed col-md-12" style="width: 100%; text-align: center; font-size: 14px; font-weight: bold">
                            <tbody id="bodyPrecio">

                            </tbody>
                        </table>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    cargarListaPreciosDefinitivos();

    function cargarListaPreciosDefinitivos () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'precio', action: 'definitivoPrecio_ajax')}',
            data:{
                detalle: '${detalle?.id}',
                fuente: '${fuente}'
            },
            success: function (msg){
                $("#bodyPrecio").html(msg);
            }
        });
    }

    function guardarValorProyecto() {
        var dialog = cargarLoader("Guardando...");
        var detalle= '${detalle?.id}';
        var id= $('input:radio[name=precioProyecto]:checked').val();
        var label= $('input:radio[name=precioProyecto]:checked').parent().text();
        $.ajax({
            type:'POST',
            url: "${createLink(controller: 'precio', action: 'guardarPrecioProyecto_ajax')}",
            data:{
                detalle: detalle,
                valor: id,
                label: label
            },
            success: function (msg){
                dialog.modal('hide');
                var parts = msg.split("_");
                if(parts[0] == 'ok'){
                    log("Precio del detalle guardado correctamente","success");
                    cargarListaPreciosDefinitivos();
                }else{
                    if(parts[0] == 'er'){
                        mensajeError("No es posible modificar los valores, este precio ya esta siendo usado" + '<br>'+ "por el proyecto: " + '</br>' + parts[1])
                    }else{
                        log("Error al guardar el precio del detalle","error");
                    }
                }
            }
        });
    }

    function guardarValorProforma() {
        var dialog = cargarLoader("Guardando...");
        var detalle= '${detalle?.id}';
        var id= $('input:radio[name=precioProforma]:checked').val();
        var label= $('input:radio[name=precioProforma]:checked').parent().text();
        $.ajax({
            type:'POST',
            url: "${createLink(controller: 'precio', action: 'guardarPrecioProforma_ajax')}",
            data:{
                detalle: detalle,
                valor: id,
                label: label
            },
            success: function (msg){
                dialog.modal('hide');
                var parts = msg.split("_");
                if(parts[0] == 'ok'){
                    log("Precio de proforma guardado correctamente","success");
                    cargarListaPreciosDefinitivos()
                }else{
                    if(parts[0] == 'er'){
                        mensajeError("No es posible modificar los valores, este precio ya esta siendo usado" + '<br>'+ "por el proyecto: " + '</br>' + parts[1])
                    }else{
                        log("Error al guardar el precio de la proforma","error");
                    }
                }
            }
        });
    }

</script>
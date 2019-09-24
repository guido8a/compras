<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/09/19
  Time: 9:24
--%>
<g:form class="form-horizontal" name="frmSavePrecios">
    <div class="form-group">
        <span class="grupo">
            <label for="precio" class="col-md-4 control-label text-info" style="font-size: 12px">
                Precio a la fecha <strong style="color: #a32713">${precio?.fecha?.format("dd-MM-yyyy")} </strong> :
            </label>
            <div class="col-md-4">
                <g:textField name="precio" id="precioItem" maxlength="14" class="form-control required number" value="${precio?.precioUnitario ?: 0.0}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>



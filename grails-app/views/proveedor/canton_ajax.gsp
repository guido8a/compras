<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 29/10/19
  Time: 11:22
--%>

<g:select name="canton" id="cantonId" from="${cantones}" value="${canton}" optionKey="id" optionValue="nombre" class="form-control required cnt" noSelection="${['null':'Seleccione...']}"/>
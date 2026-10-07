<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dominio.TipoSeguro" %>
<%
    String mensaje = (String) request.getAttribute("mensaje");
    Integer proximoId = (Integer) request.getAttribute("proximoId");
    ArrayList<TipoSeguro> listaTipos = (ArrayList<TipoSeguro>) request.getAttribute("listaTipos");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Agregar Seguros</title>
</head>
<body>
    <nav>
        <h1>Seguros Group</h1>
        <a href="ServletInicio">Inicio</a> |
        <a href="ServletAgregarSeguro">Agregar Seguros</a> |
        <a href="ServletListarSeguros">Listar Seguros</a> |
        <a href="ServletEliminarSeguro">Eliminar Seguro</a>
    </nav>
    <hr>

    <h2>Agregar Seguros</h2>

    <p style="color: blue;"><%= mensaje != null ? mensaje : "" %></p>

    <form method="post" action="ServletAgregarSeguro">
        Id Seguro: <%= proximoId != null ? proximoId : "" %>
        <br><br>

        Descripción:
        <input type="text" name="txtDescripcion" maxlength="200" required>
        <br><br>

        Tipo de Seguro:
        <select name="ddlTipoSeguro" required>
            <%
                if (listaTipos != null) {
                    for (TipoSeguro tipo : listaTipos) {
            %>
                        <option value="<%= tipo.getIdTipo() %>"><%= tipo.getDescripcion() %></option>
            <%
                    }
                }
            %>
        </select>
        <br><br>

        Costo contratación:
        <input type="number" step="0.01" name="txtCostoContratacion" required>
        <br><br>

        Costo Máximo Asegurado:
        <input type="number" step="0.01" name="txtCostoAsegurado" required>
        <br><br>

        <input type="submit" name="btnAceptar" value="Aceptar">
    </form>
</body>
</html>
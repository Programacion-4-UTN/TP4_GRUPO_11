<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dominio.Seguro" %>
<%
    String mensaje = (String) request.getAttribute("mensaje");
    Seguro seguroBuscado = (Seguro) request.getAttribute("seguroBuscado");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Seguro</title>
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

    <h2>Eliminar Seguro</h2>
    
    <p style="color: red;"><%= mensaje != null ? mensaje : "" %></p>

    <% if (seguroBuscado == null) { %>
        <form method="post" action="ServletEliminarSeguro">
            ID del Seguro:
            <input type="text" name="txtIdSeguro" required>
            <input type="submit" name="btnBuscar" value="Buscar">
        </form>
    <% } else { %>
        <form method="post" action="ServletEliminarSeguro">
            <input type="hidden" name="txtIdOculto" value="<%= seguroBuscado.getIdSeguro() %>">
            <ul>
                <li>ID Seguro: <%= seguroBuscado.getIdSeguro() %></li>
                <li>Descripción: <%= seguroBuscado.getDescripcion() %></li>
                <li>Tipo: <%= seguroBuscado.getDescripcionTipo() %></li>
                <li>Costo Contratación: $<%= seguroBuscado.getCostoContratacion() %></li>
                <li>Costo Asegurado: $<%= seguroBuscado.getCostoAsegurado() %></li>
            </ul>
            <br>
            <input type="submit" name="btnEliminar" value="Eliminar">
            <a href="ServletEliminarSeguro">Cancelar</a>
        </form>
    <% } %>
</body>
</html>
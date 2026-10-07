<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Recibimos los datos que nos va a mandar el ServletInicio
    Integer totalSeguros = (Integer) request.getAttribute("totalSeguros");
    Integer totalTipos = (Integer) request.getAttribute("totalTipos");
    String error = (String) request.getAttribute("error");
    
    // Si entran directo al JSP y los valores son nulos, les ponemos 0 por defecto
    if(totalSeguros == null) totalSeguros = 0;
    if(totalTipos == null) totalTipos = 0;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio - Seguros Group</title>
</head>
<body>
 
    <div class="contenido">
        
        <nav>
            <h1>Seguros Group</h1>
            <!--  Apunta a servlet en lugar de .jsp -->
            <a href="ServletInicio">Inicio</a> |
            <a href="ServletAgregarSeguro">Agregar Seguros</a> |
            <a href="ServletListarSeguros">Listar Seguros</a> |
            <a href="ServletEliminarSeguro">Eliminar Seguros</a>
        </nav>
        <hr>
        
        <p>Soy la página de inicio</p>
        
        <% if (error != null) { %>
            <p class="error" style="color: red;">No se pudo conectar a la base de datos: <%= error %></p>
        <% } else { %>
            <p>Hay <b><%= totalSeguros %></b> seguros cargados en <b><%= totalTipos %></b> tipos de seguro.</p>
        <% } %>
        
    </div>
</body>
</html>
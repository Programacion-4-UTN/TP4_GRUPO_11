<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="db-connection.jsp" %>
<%
    int totalSeguros = 0;
    int totalTipos = 0;
    String error = null;
    try (Connection cn = abrirConexion();
         Statement st = cn.createStatement()) {
        try (ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM seguros")) {
            if (rs.next()) totalSeguros = rs.getInt(1);
        }
        try (ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM tipoSeguros")) {
            if (rs.next()) totalTipos = rs.getInt(1);
        }
    } catch (Exception e) {
        error = e.getMessage();
    }
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
    <a href="Inicio.jsp">Inicio</a> |
    <a href="AgregarSeguro.jsp">Agregar Seguros</a> |
    <a href="ListarSeguros.jsp">Listar Seguros</a>
</nav>
<hr>
        <p>Soy la página de inicio</p>
        <% if (error != null) { %>
            <p class="error">No se pudo conectar a la base de datos: <%= esc(error) %></p>
        <% } else { %>
            <p>Hay <b><%= totalSeguros %></b> seguros cargados en <b><%= totalTipos %></b> tipos de seguro.</p>
        <% } %>
    </div>
</body>
</html>
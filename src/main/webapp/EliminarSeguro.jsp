<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db-connection.jsp" %>

<%
    String mensaje = "";
    boolean seguroEncontrado = false;
    
    String idBusqueda = "";
    String desc = "";
    String tipoDesc = "";
    double costoC = 0;
    double costoA = 0;

    if (request.getParameter("btnBuscar") != null) {
        idBusqueda = request.getParameter("txtIdSeguro");
        
        Connection con = abrirConexion();
        String sql = "SELECT s.descripcion, t.descripcion as tipo, s.costoContratacion, s.costoAsegurado " +
                     "FROM seguros s INNER JOIN tipoSeguros t ON s.idTipo = t.idTipo " +
                     "WHERE s.idSeguro = ?";
        
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(idBusqueda));
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            seguroEncontrado = true;
            desc = rs.getString("descripcion");
            tipoDesc = rs.getString("tipo");
            costoC = rs.getDouble("costoContratacion");
            costoA = rs.getDouble("costoAsegurado");
        } else {
            mensaje = "No se encontró el seguro.";
        }
        
        rs.close(); 
        ps.close(); 
        con.close();
    }

    if (request.getParameter("btnEliminar") != null) {
        String idEliminar = request.getParameter("txtIdOculto");
        
        Connection con = abrirConexion();
        String sql = "DELETE FROM seguros WHERE idSeguro = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(idEliminar));
        
        int filas = ps.executeUpdate();
        
        ps.close(); 
        con.close();
        
        if (filas > 0) {
            mensaje = "Seguro eliminado.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Seguro</title>
</head>
<body>

    <a href="Inicio.jsp">Inicio</a> |
    <a href="AgregarSeguro.jsp">Agregar Seguros</a> |
    <a href="ListarSeguros.jsp">Listar Seguros</a> |
    <a href="EliminarSeguro.jsp">Eliminar Seguro</a>

    <h2>Eliminar Seguro</h2>
    
    <p><%= mensaje %></p>

    <% if (seguroEncontrado == false) { %>
    
        <form method="post">
            ID del Seguro:
            <input type="text" name="txtIdSeguro">
            <input type="submit" name="btnBuscar" value="Buscar">
        </form>
        
    <% } else { %>
    
        <form method="post">
            <input type="hidden" name="txtIdOculto" value="<%= idBusqueda %>">
            
            <ul>
                <li>ID Seguro: <%= idBusqueda %></li>
                <li>Descripción: <%= desc %></li>
                <li>Tipo: <%= tipoDesc %></li>
                <li>Costo Contratación: $<%= costoC %></li>
                <li>Costo Asegurado: $<%= costoA %></li>
            </ul>
            
            <br>
            <input type="submit" name="btnEliminar" value="Eliminar">
            <a href="EliminarSeguro.jsp">Cancelar</a>
        </form>
        
    <% } %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dominio.Seguro" %>
<%@ page import="dominio.TipoSeguro" %>
<%
    ArrayList<TipoSeguro> listaTipos = (ArrayList<TipoSeguro>) request.getAttribute("listaTipos");
    ArrayList<Seguro> listaSeguros = (ArrayList<Seguro>) request.getAttribute("listaSeguros");
    
    String filtroSeleccionado = (String) request.getAttribute("filtroSeleccionado");
    if (filtroSeleccionado == null) {
        filtroSeleccionado = "0";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listar Seguros</title>
    <style>
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        table, th, td { border: 1px solid #000; }
        th, td { padding: 8px; text-align: left; }
        th { font-weight: bold; }
    </style>
</head>
<body>
    <nav>
        <h1>Seguros Group</h1>
        <a href="Inicio.jsp">Inicio</a> |
        <a href="ServletAgregarSeguro">Agregar Seguros</a> |
        <a href="ServletListarSeguros">Listar Seguros</a>
        <a href="ServletEliminarSeguro">Eliminar Seguros</a>
        <hr>
    </nav>

    <h2>Tipo de seguros en la base de datos</h2>

    <form method="get" action="ServletListarSeguros">
        <label for="ddlFiltroTipo">Busqueda por tipo de seguros: </label>
        <select name="ddlFiltroTipo" id="ddlFiltroTipo">
            <option value="0" <%= filtroSeleccionado.equals("0") ? "selected" : "" %>>-- Todos los tipos --</option>
            <%
                if (listaTipos != null) {
                    for (TipoSeguro tipo : listaTipos) {
                        String selected = filtroSeleccionado.equals(String.valueOf(tipo.getIdTipo())) ? "selected" : "";
            %>
                        <option value="<%= tipo.getIdTipo() %>" <%= selected %>><%= tipo.getDescripcion() %></option>
            <%
                    }
                }
            %>
        </select>
        <input type="submit" name="btnFiltrar" value="Filtrar">
    </form>

    <table>
        <thead>
            <tr>
                <th>ID Seguro</th>
                <th>Descripción Seguro</th>
                <th>Descripción Tipo Seguro</th>
                <th>Costo Contratación</th>
                <th>Costo Máximo Asegurado</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (listaSeguros != null && !listaSeguros.isEmpty()) {
                    for (Seguro seguro : listaSeguros) {
            %>
                        <tr>
                            <td><%= seguro.getIdSeguro() %></td>
                            <td><%= seguro.getDescripcion() %></td>
                            <td><%= seguro.getDescripcionTipo() %></td>
                            <td><%= seguro.getCostoContratacion() %></td>
                            <td><%= seguro.getCostoAsegurado() %></td>
                        </tr>
            <%
                    }
                } else {
            %>
                    <tr>
                        <td colspan="5" style="text-align: center;">No hay seguros registrados para el filtro seleccionado.</td>
                    </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
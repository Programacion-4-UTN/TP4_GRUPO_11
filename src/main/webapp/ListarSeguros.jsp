<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="db-connection.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listar Seguros</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #000;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <nav>
        <h1>Seguros Group</h1>
        <a href="Inicio.jsp">Inicio</a> |
        <a href="AgregarSeguro.jsp">Agregar Seguros</a> |
        <a href="ListarSeguros.jsp">Listar Seguros</a>
        <hr>
    </nav>

    <h2>"Tipo de seguros en la base de datos"</h2>

    <%
        // Capturar filtro seleccionado
        String idTipoFiltro = request.getParameter("ddlFiltroTipo");
        if (idTipoFiltro == null) {
            idTipoFiltro = "0"; // 0 para mostrar todos por defecto
        }
    %>

    <!-- Formulario de Búsqueda / Filtro -->
    <form method="get" action="ListarSeguros.jsp">
        <label for="ddlFiltroTipo">Busqueda por tipo de seguros: </label>
        <select name="ddlFiltroTipo" id="ddlFiltroTipo">
            <option value="0" <%= idTipoFiltro.equals("0") ? "selected" : "" %>>-- Todos los tipos --</option>
            <%
                Connection cnTipos = null;
                Statement stTipos = null;
                ResultSet rsTipos = null;
                try {
                    cnTipos = abrirConexion();
                    stTipos = cnTipos.createStatement();
                    rsTipos = stTipos.executeQuery("SELECT idTipo, descripcion FROM tipoSeguros");
                    while (rsTipos.next()) {
                        String id = String.valueOf(rsTipos.getInt("idTipo"));
                        String selected = id.equals(idTipoFiltro) ? "selected" : "";
            %>
                        <option value="<%= id %>" <%= selected %>>
                            <%= esc(rsTipos.getString("descripcion")) %>
                        </option>
            <%
                    }
                } catch(Exception e) {
                    out.println("<option value='0'>Error al cargar tipos</option>");
                } finally {
                    if (rsTipos != null) try { rsTipos.close(); } catch(Exception ignored) {}
                    if (stTipos != null) try { stTipos.close(); } catch(Exception ignored) {}
                    if (cnTipos != null) try { cnTipos.close(); } catch(Exception ignored) {}
                }
            %>
        </select>
        <input type="submit" name="btnFiltrar" value="Filtrar">
    </form>

    <!-- Tabla de resultados -->
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
                Connection cnTabla = null;
                PreparedStatement psTabla = null;
                ResultSet rsTabla = null;
                try {
                    cnTabla = abrirConexion();
                    String sql = "SELECT s.idSeguro, s.descripcion AS descSeguro, ts.descripcion AS descTipo, "
                               + "s.costoContratacion, s.costoAsegurado "
                               + "FROM seguros s "
                               + "INNER JOIN tipoSeguros ts ON s.idTipo = ts.idTipo ";

                    if (!idTipoFiltro.equals("0")) {
                        sql += "WHERE s.idTipo = ?";
                        psTabla = cnTabla.prepareStatement(sql);
                        psTabla.setInt(1, Integer.parseInt(idTipoFiltro));
                    } else {
                        psTabla = cnTabla.prepareStatement(sql);
                    }

                    rsTabla = psTabla.executeQuery();
                    boolean hayRegistros = false;

                    while (rsTabla.next()) {
                        hayRegistros = true;
            %>
                        <tr>
                            <td><%= rsTabla.getInt("idSeguro") %></td>
                            <td><%= esc(rsTabla.getString("descSeguro")) %></td>
                            <td><%= esc(rsTabla.getString("descTipo")) %></td>
                            <td><%= rsTabla.getDouble("costoContratacion") %></td>
                            <td><%= rsTabla.getDouble("costoAsegurado") %></td>
                        </tr>
            <%
                    }

                    if (!hayRegistros) {
            %>
                        <tr>
                            <td colspan="5" style="text-align: center;">No hay seguros registrados para el filtro seleccionado.</td>
                        </tr>
            <%
                    }
                } catch(Exception e) {
            %>
                    <tr>
                        <td colspan="5" style="color: red;">Error al consultar los seguros: <%= esc(e.getMessage()) %></td>
                    </tr>
            <%
                } finally {
                    if (rsTabla != null) try { rsTabla.close(); } catch(Exception ignored) {}
                    if (psTabla != null) try { psTabla.close(); } catch(Exception ignored) {}
                    if (cnTabla != null) try { cnTabla.close(); } catch(Exception ignored) {}
                }
            %>
        </tbody>
    </table>
</body>
</html>
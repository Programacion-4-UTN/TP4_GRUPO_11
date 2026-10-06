<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="db-connection.jsp" %>

<%
    String mensaje = "";


    // Conseguir próximo ID
    Connection con = abrirConexion();
    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery(
        "SELECT COALESCE(MAX(idSeguro), 0) + 1 AS id FROM seguros"
    );

    int idSeguro = 1;

    if (rs.next()) {
        idSeguro = rs.getInt("id");
    }

    rs.close();
    st.close();
    con.close();


    // guardar el seguro
    if (request.getParameter("btnAceptar") != null) {

        String descripcion = request.getParameter("txtDescripcion");
        int idTipo = Integer.parseInt(request.getParameter("ddlTipoSeguro"));
        double costoContratacion = Double.parseDouble(request.getParameter("txtCostoContratacion"));
        double costoAsegurado = Double.parseDouble(request.getParameter("txtCostoAsegurado"));

        con = abrirConexion();

        String sql = "INSERT INTO seguros (descripcion, idTipo, costoContratacion, costoAsegurado) VALUES (?, ?, ?, ?)";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, descripcion);
        ps.setInt(2, idTipo);
        ps.setDouble(3, costoContratacion);
        ps.setDouble(4, costoAsegurado);

        ps.executeUpdate();

        ps.close();
        con.close();

        mensaje = "Seguro agregado correctamente";
    }
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Agregar Seguros</title>
</head>

<body>

    <a href="Inicio.jsp">Inicio</a> |
    <a href="AgregarSeguro.jsp">Agregar Seguros</a> |
    <a href="ListarSeguros.jsp">Listar Seguros</a>

    <h2>Agregar Seguros</h2>

    <p><%= mensaje %></p>

    <form method="post">

        Id Seguro:
        <%= idSeguro %>

        <br><br>

        Descripción:
        <input type="text" name="txtDescripcion" required>

        <br><br>

        Tipo de Seguro:

        <select name="ddlTipoSeguro" required>

            <%
                con = abrirConexion();
                st = con.createStatement();

                rs = st.executeQuery(
                    "SELECT idTipo, descripcion FROM tipoSeguros"
                );

                while (rs.next()) {
            %>

                <option value="<%= rs.getInt("idTipo") %>">
                    <%= rs.getString("descripcion") %>
                </option>

            <%
                }

                rs.close();
                st.close();
                con.close();
            %>

        </select>

        <br><br>

        Costo contratación:
        <input type="text" name="txtCostoContratacion" required>

        <br><br>

        Costo Máximo Asegurado:
        <input type="text" name="txtCostoAsegurado" required>

        <br><br>

        <input type="submit" name="btnAceptar" value="Aceptar">

    </form>

</body>

</html>
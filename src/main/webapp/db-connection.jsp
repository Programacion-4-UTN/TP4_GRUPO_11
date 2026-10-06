<%@ page import="java.sql.*" %>
<%!
    // === Ajustá estos valores a tu MySQL ===
    private static final String DB_URL  = "jdbc:mysql://localhost:3306/SegurosGroup?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=America/Argentina/Buenos_Aires";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root";

    private Connection abrirConexion() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }

    // Evita que el texto de la base rompa el HTML (XSS)
    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
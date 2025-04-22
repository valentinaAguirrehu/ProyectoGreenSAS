<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.mail.internet.MimeBodyPart" %>
<%@ page import="javax.mail.internet.MimeMultipart" %>
<%@ page import="javax.mail.Multipart" %>
<%@ page import="javax.mail.PasswordAuthentication" %>
<%@ page import="javax.mail.Authenticator" %>
<link rel="stylesheet" href="../presentacion/styleContra.css">

<%
    String mensaje = "";
    int enviados = 0;

    final String correoEnvia = "huellitasweb5@gmail.com";
    final String claveCorreo = "hkjf yjaa crui awbs";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8";
        conn = DriverManager.getConnection(url, "adso", "utilizar");

        // Consulta para obtener los contratos próximos a vencer
        String sql = "SELECT p.identificacion, p.nombres, p.apellidos, " +
                     "p.establecimiento, p.email, p.fechaTerPriContrato AS fechaVencimiento " +
                     "FROM persona p " +
                     "WHERE DATEDIFF(p.fechaTerPriContrato, CURDATE()) IN (30, 15)";
        stmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs = stmt.executeQuery();

        // Propiedades para el correo
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(correoEnvia, claveCorreo);
            }
        };

        Session mailSession = Session.getInstance(props, auth);

        // Enviar notificaciones a las personas con contratos próximos a vencer
        while (rs.next()) {
            String nombreCompleto = rs.getString("nombres") + " " + rs.getString("apellidos");
            String establecimiento = rs.getString("establecimiento");
            String email = rs.getString("email");
            String fechaVencimiento = rs.getString("fechaVencimiento");
            int identificacionPersona = rs.getInt("identificacion");

            String asunto = "Notificación de Vencimiento de Contrato";
            String cuerpoCorreo = "Hola " + nombreCompleto + ",\n\n"
                    + "Te informamos que tu contrato en el establecimiento " + establecimiento
                    + " está próximo a vencer el día " + fechaVencimiento + ".\n"
                    + "Por favor, comunícate con Gestión Humana para más información.\n\n"
                    + "Atentamente,\n"
                    + "Gestión Humana - Green S.A.S";

            try {
                MimeMessage mensajeMail = new MimeMessage(mailSession);
                mensajeMail.setFrom(new InternetAddress(correoEnvia, "Gestión Humana"));
                mensajeMail.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                mensajeMail.setSubject(asunto);

                MimeBodyPart cuerpo = new MimeBodyPart();
                cuerpo.setText(cuerpoCorreo);

                Multipart multipart = new MimeMultipart();
                multipart.addBodyPart(cuerpo);

                mensajeMail.setContent(multipart);
                Transport.send(mensajeMail);
                enviados++;

                // Guardar en historialCorreos (solo identificacionAdministrador y fechaEnvio)
                String insertHistorial = "INSERT INTO historialCorreos (identificacionAdministrador, fechaEnvio) " +
                                         "VALUES (?, NOW())";
                PreparedStatement insertStmt = conn.prepareStatement(insertHistorial);
                insertStmt.setInt(1, 1); // Asume que el administrador tiene identificacion 1 (o cambiar por la identificación real)
                insertStmt.executeUpdate();
                insertStmt.close();
            } catch (MessagingException e) {
                mensaje += "Error al enviar a " + email + ": " + e.getMessage() + "<br>";
                e.printStackTrace();
            }
        }

        if (enviados > 0) {
            mensaje = "Correos enviados exitosamente a " + enviados + " persona(s).";
        } else {
            mensaje = "No hay contratos próximos a vencer dentro de 15 o 30 días.";
        }

    } catch (Exception e) {
        mensaje = "Error general: " + e.getMessage();
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { mensaje += "Error al cerrar ResultSet: " + e.getMessage(); e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { mensaje += "Error al cerrar Statement: " + e.getMessage(); e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { mensaje += "Error al cerrar Conexión: " + e.getMessage(); e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Notificación de Contratos</title>
    <link rel="stylesheet" href="../presentacion/styleContra.css">
</head>
<body>
    <div class="container">
        <h1 class="title">Notificación de Contratos</h1>
        <p class="subtitulo"><%= mensaje %></p>
        <div class="volver">
            <a href="index.jsp">Volver al Inicio</a>
        </div>
    </div>
</body>
</html>

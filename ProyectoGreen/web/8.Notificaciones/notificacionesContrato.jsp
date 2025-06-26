<%@ page import="clases.Administrador" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*, javax.mail.*, javax.mail.internet.*" %>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    int enviados = 0;
    final String correoEnvia = "softwaregestionhumana@gmail.com";
    final String claveCorreo = "cyyu usqo rrss dzoy";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8",
            "adso", "utilizar"
        );

     String sql = "SELECT p.identificacion, p.nombres, p.apellidos, p.email, p.celular, "
           + "il.centroCostos, il.unidadNegocio, il.fechaIngreso, c.nombre AS cargo, il.fechaTerPriContrato "
           + "FROM persona p "
           + "JOIN informacionlaboral il ON p.identificacion = il.identificacion "
           + "JOIN cargo c ON il.idCargo = c.id "
           + "WHERE p.tipo = 'C' "
           + "AND il.fechaTerPriContrato BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 50 DAY)";


        stmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs = stmt.executeQuery();

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session sessionMail = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(correoEnvia, claveCorreo);
            }
        });

        // Envío resumen a administradores
        PreparedStatement adminStmt = conn.prepareStatement(
            "SELECT email FROM administrador WHERE estado = 'Activo'"
        );
        ResultSet adminRs = adminStmt.executeQuery();

        StringBuilder resumen = new StringBuilder(
            "Buen día,\n\nLe informamos que los siguientes contratos vencerán en los próximos 50 días:\n\n"
        );
        // Re-ejecuta sentencia para construir el resumen
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        while (rs.next()) {
            resumen.append("Cédula: ").append(rs.getString("identificacion")).append("\n")
                   .append("Nombre: ").append(rs.getString("nombres")).append(" ").append(rs.getString("apellidos")).append("\n")
                   .append("Email: ").append(rs.getString("email")).append("\n")
                   .append("Celular: ").append(rs.getString("celular")).append("\n")
                   .append("Centro de Costos: ").append(rs.getString("centroCostos")).append("\n")
                   .append("Unidad de Negocio: ").append(rs.getString("unidadNegocio")).append("\n")
                   .append("Cargo: ").append(rs.getString("cargo")).append("\n")
                   .append("Fecha de Ingreso: ").append(rs.getString("fechaIngreso")).append("\n")
                   .append("Fecha de Vencimiento: ").append(rs.getString("fechaTerPriContrato")).append("\n")
                   .append("--------------------------------------------------\n");
        }
        resumen.append("\nGracias por leer este mensaje.\n\n")
               .append("Saludos cordiales.");

        while (adminRs.next()) {
            String emailAdmin = adminRs.getString("email");
            MimeMessage mensajeAdmin = new MimeMessage(sessionMail);
            mensajeAdmin.setFrom(new InternetAddress(correoEnvia, " Notificaciones Gestión Humana"));
            mensajeAdmin.setRecipient(Message.RecipientType.TO, new InternetAddress(emailAdmin));
            mensajeAdmin.setSubject("Contratos próximos a vencer");
            mensajeAdmin.setText(resumen.toString());
            Transport.send(mensajeAdmin);
            enviados++;

            PreparedStatement insertAdminHist = conn.prepareStatement(
                "INSERT INTO historialCorreos (destinatario, tipoDestinatario, fechaEnvio) VALUES (?, 'Administradores', NOW())"
            );
            insertAdminHist.setString(1, emailAdmin);
            insertAdminHist.executeUpdate();
            insertAdminHist.close();
        }

        adminRs.close();
        adminStmt.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }

    response.sendRedirect("../8.Notificaciones/HistorialCorreos.jsp");
%>

<%@ page import="clases.Administrador" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*, javax.mail.*, javax.mail.internet.*" %>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    int enviados = 0;
    final String correoEnvia = "huellitasweb5@gmail.com";
    final String claveCorreo = "hkjf yjaa crui awbs";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8";
        conn = DriverManager.getConnection(url, "adso", "utilizar");

        String sql = "SELECT p.identificacion, p.nombres, p.apellidos, p.email, p.celular, "
                   + "il.establecimiento, il.unidadNegocio, c.nombre AS cargo, il.fechaTerPriContrato "
                   + "FROM persona p "
                   + "JOIN informacionlaboral il ON p.identificacion = il.identificacion "
                   + "JOIN cargo c ON p.idCargo = c.id "
                   + "WHERE p.tipo = 'C' AND il.fechaTerPriContrato BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)";
        
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

        while (rs.next()) {
            String nombres = rs.getString("nombres");
            String apellidos = rs.getString("apellidos");
            String email = rs.getString("email");
            String celular = rs.getString("celular");
            String establecimiento = rs.getString("establecimiento");
            String unidadNegocio = rs.getString("unidadNegocio");
            String cargo = rs.getString("cargo");
            String fechaVencimiento = rs.getString("fechaTerPriContrato");

            String asunto = "Notificación de Vencimiento de Contrato";
            String cuerpo = "Hola " + nombres + " " + apellidos + ",\n\n"
                    + "Te informamos que tu contrato está próximo a vencer el día " + fechaVencimiento + ".\n"
                    + "Por favor, comunícate con Gestión Humana para más información.\n\n"
                    + "Detalles de tu información:\n"
                    + "Celular: " + celular + "\n"
                    + "Establecimiento: " + establecimiento + "\n"
                    + "Unidad de Negocio: " + unidadNegocio + "\n"
                    + "Cargo: " + cargo + "\n\n"
                    + "Atentamente,\nGestión Humana - Green S.A.S";

            MimeMessage mensajeCorreo = new MimeMessage(sessionMail);
            mensajeCorreo.setFrom(new InternetAddress(correoEnvia, "Gestión Humana"));
            mensajeCorreo.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            mensajeCorreo.setSubject(asunto);
            mensajeCorreo.setText(cuerpo);

            Transport.send(mensajeCorreo);
            enviados++;

            PreparedStatement insertHist = conn.prepareStatement(
                    "INSERT INTO historialCorreos (destinatario, tipoDestinatario, fechaEnvio) VALUES (?, 'Persona', NOW())"
            );
            insertHist.setString(1, email);
            insertHist.executeUpdate();
            insertHist.close();
        }

        // Ahora obtenemos los emails de los administradores activos
        PreparedStatement adminStmt = conn.prepareStatement("SELECT email FROM administrador WHERE estado = 'Activo'");
        ResultSet adminRs = adminStmt.executeQuery();

        // Crear resumen para administradores
        StringBuilder resumen = new StringBuilder("Buen día,\n\nLe informamos que los siguientes contratos vencerán en los próximos 30 días:\n\n");
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();

        while (rs.next()) {
            resumen.append("Cédula: ").append(rs.getString("identificacion")).append("\n")
                   .append("Nombre: ").append(rs.getString("nombres")).append(" ").append(rs.getString("apellidos")).append("\n")
                   .append("Email: ").append(rs.getString("email")).append("\n")
                   .append("Celular: ").append(rs.getString("celular")).append("\n")
                   .append("Establecimiento: ").append(rs.getString("establecimiento")).append("\n")
                   .append("Unidad de Negocio: ").append(rs.getString("unidadNegocio")).append("\n")
                   .append("Cargo: ").append(rs.getString("cargo")).append("\n")
                   .append("Fecha de Vencimiento: ").append(rs.getString("fechaTerPriContrato")).append("\n")
                   .append("--------------------------------------------------\n");
        }

        resumen.append("\nTenga en cuenta que los colaboradores correspondientes ya han sido notificados por correo electrónico.\n\n")
               .append("Saludos cordiales.");

        // Envío del resumen a cada administrador
        while (adminRs.next()) {
            String emailAdmin = adminRs.getString("email");

            MimeMessage mensajeAdmin = new MimeMessage(sessionMail);
            mensajeAdmin.setFrom(new InternetAddress(correoEnvia, "Gestión Humana"));
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

    // Redirección final al historial
    response.sendRedirect("../8.Notificaciones/HistorialCorreos.jsp");
%>

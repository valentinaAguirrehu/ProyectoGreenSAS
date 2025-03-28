<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="java.io.File"%>
<%@page import="clases.DetallesHistoria"%>

<%
    boolean subioArchivo = false;
    Map<String, String> variables = new HashMap<>(); // Para almacenar los datos del formulario

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (!isMultipart) {
        variables.put("accion", request.getParameter("accion"));
        variables.put("identificacion", request.getParameter("identificacion"));
        variables.put("nombreDocumento", request.getParameter("nombreDocumento"));
        variables.put("tipo", request.getParameter("tipo"));
    } else {
        // Configuración para manejar archivos
        String rutaActual = getServletContext().getRealPath("/");
        System.out.println("Ruta actual: " + rutaActual);

        File destino = new File(rutaActual + "/documentos/");
        if (!destino.exists()) {
            destino.mkdirs();
        }

        DiskFileItemFactory factory = new DiskFileItemFactory(1024 * 1024, destino);
        ServletFileUpload upload = new ServletFileUpload(factory);
        File archivo = null;

        ServletRequestContext origen = new ServletRequestContext(request);
        List elementosFormulario = upload.parseRequest(origen);
        Iterator iterador = elementosFormulario.iterator();

        while (iterador.hasNext()) {
            FileItem elemento = (FileItem) iterador.next();
            if (elemento.isFormField()) {
                System.out.println("Campo: " + elemento.getFieldName() + " = " + elemento.getString());
                variables.put(elemento.getFieldName(), elemento.getString());
            } else {
                System.out.println("Archivo recibido: " + elemento.getName());
                if (!elemento.getName().equals("")) {
                    subioArchivo = true;
                    archivo = new File(destino, elemento.getName());
                    elemento.write(archivo);
                    variables.put(elemento.getFieldName(), "documentos/" + elemento.getName());
                }
            }
        }
    }

    // Mostrar las variables recibidas en consola
    System.out.println("Contenido de variables:");
    for (Map.Entry<String, String> entry : variables.entrySet()) {
        System.out.println(entry.getKey() + " = " + entry.getValue());
    }

    // Crear objeto y asignar valores
    DetallesHistoria documento = new DetallesHistoria();
    documento.setIdPersona(variables.get("identificacion"));
    documento.setNombreDocumento(variables.get("nombreDocumento"));
    documento.setTipo(variables.get("tipo"));
    documento.setDocumentoPDF(variables.get("documentoPDF"));

    // Verificar la acción
    String accion = variables.get("accion");
    if (accion == null) {
        System.out.println("ERROR: La variable 'accion' es NULL");
        accion = "NULO"; // Para evitar errores en el switch
    }

    switch (accion) {
        case "Adicionar":
            System.out.println("Ejecutando 'grabar()'");
            documento.grabar();
            break;
        case "Modificar":
            System.out.println("Ejecutando 'modificar()'");
            documento.modificar();
            break;
        case "Eliminar":
            variables.put("codigoDocumento", request.getParameter("codigoDocumento"));
            variables.put("identificacion", request.getParameter("idPersona"));
            variables.put("tipo", request.getParameter("tipo"));

            String codigoDocumento = request.getParameter("codigoDocumento");
            System.out.println("Valor recibido de codigoDocumento: " + codigoDocumento);

            System.out.println("Ejecutando 'eliminar()'");
            documento.setId(variables.get("codigoDocumento")); // Asigna el ID antes de eliminar    
            documento = new DetallesHistoria(codigoDocumento);
            documento.eliminar();
            break;

        default:
            System.out.println("Acción no válida: " + accion);
            out.println("<script>alert('Acción no válida'); history.back();</script>");
            return;
    }

    // Redirigir de nuevo a la página de detalle
    response.sendRedirect("detalleHistoria.jsp?identificacion=" + variables.get("identificacion") + "&tipo=" + variables.get("tipo"));
%>

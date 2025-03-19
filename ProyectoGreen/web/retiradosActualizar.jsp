<%@page import="clases.Persona"%>
<%@page import="clases.Retirados"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Map<String, String> variables = new HashMap<>();
    boolean isMultipart = ServletFileUpload.isMultipartContent(request); // Verificamos si es un formulario con archivos
   
    if (!isMultipart) {
        variables.put("accion", request.getParameter("accion"));
        variables.put("id", request.getParameter("id"));
        variables.put("cedula", request.getParameter("cedula"));
        variables.put("nombres", request.getParameter("nombres"));
        variables.put("establecimiento", request.getParameter("establecimiento"));
        variables.put("fechaIngreso", request.getParameter("fechaIngreso"));
        variables.put("fechaRetiro", request.getParameter("fechaRetiro"));
        variables.put("cargo", request.getParameter("cargo"));
        variables.put("numCaja", request.getParameter("numCaja"));
        variables.put("numCarpeta", request.getParameter("numCarpeta"));
        variables.put("observaciones", request.getParameter("observaciones"));
    } else {
        // Si es multipart, procesamos los campos del formulario
        ServletRequestContext origen = new ServletRequestContext(request);
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> elementosFormulario = upload.parseRequest(origen);
        
        // Extraemos los campos del formulario
        for (FileItem elemento : elementosFormulario) {
            if (elemento.isFormField()) {
                variables.put(elemento.getFieldName(), elemento.getString());
            }
        }
    }

    // Creamos las instancias de Persona y Retirados usando los datos extraídos
    String identificacionAnterior = variables.get("id");
    Persona persona = new Persona(identificacionAnterior);
    Retirados retirado = new Retirados(identificacionAnterior);
    
    persona.setIdentificacion(variables.get("cedula"));
    persona.setNombres(variables.get("nombres"));
    persona.setEstablecimiento(variables.get("establecimiento"));
    persona.setFechaIngreso(variables.get("fechaIngreso"));
    persona.setFechaRetiro(variables.get("fechaRetiro"));
    
    persona.setIdCargo(variables.get("cargo"));
    retirado.setNumCaja(variables.get("numCaja"));
    retirado.setNumCarpeta(variables.get("numCarpeta"));
    retirado.setObservaciones(variables.get("observaciones"));
    
    // Dependiendo de la acción (Adicionar, Modificar, Eliminar), realizamos la operación correspondiente
    switch (variables.get("accion")) {
        case "Adicionar":
            persona.grabar();
            retirado.grabar();
            break;
        case "Modificar":
            persona.modificar(variables.get("identificacionAnterior"));
            retirado.modificar(variables.get("id"));
            break;
        case "Eliminar":
            retirado.eliminar(variables.get("id"));
            break;
    }
%>

<script type="text/javascript">
    document.location = "retirados.jsp";
</script>

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

/**
 *
 * @author Angie
 */
public class TipoPersona {
    
    private String codigo;
    private String identificacion;

    public TipoPersona(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Persona getPersona() {
        return new Persona(identificacion);
    }

    public String getNombre() {
        String nombre = null;
        switch (codigo) {
            case "A":
                nombre = "Administrador";
                break;
            default:
                nombre = "Desconocido";
                break;
        }
        return nombre;
    }

    @Override
    public String toString() {
        return getNombre();
    }

    public String getMenu() {
        String menu = "<ul>";

        switch (this.codigo) {

            case "F": 
                menu += "<nav class='navbar navbar-expand-lg navbar-light transparent-navbar' 'style='padding: 50px 50px; width: 100%;'>"; // Añadido padding para mejor espacio
                menu += "<div class='container-fluid d-flex justify-content-between align-items-center'>";

                // Logo ajustado con mejor tamaño y centrado verticalmente
                menu += "<img src='presentacion/imagenes/Logo-Fundacion.png' alt='Logo' width='80' height='80' class='d-inline-block align-text-top me-3'>";

                // Botón para colapsar el menú en pantallas pequeñas
                menu += "<button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarNav' aria-controls='navbarNav' aria-expanded='false' aria-label='Toggle navigation'>";
                menu += "<span class='navbar-toggler-icon'></span>";
                menu += "</button>";

                // Menú desplegable y alineado a la derecha
                menu += "<div class='collapse navbar-collapse justify-content-center' id='navbarNav'>";
                menu += "<ul class='navbar-nav'>";

                // Enlaces del menú con mejor tamaño y espaciado
                menu += "<li class='nav-item'><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=inicio.jsp' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>Inicio</a></li>";

                // Menú de Donaciones
                menu += "<li class='nav-item dropdown'>";
                menu += "<a class='nav-link dropdown-toggle d-flex align-items-center' href='#' id='donacionesDropdown' role='button' data-bs-toggle='dropdown' aria-expanded='false' style='padding: 8px 10px; font-size: 0.9rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/donar.png' alt='Donaciones' width='23' height='23' class='me-2'> Donaciones</a>";
                menu += "<ul class='dropdown-menu' aria-labelledby='donacionesDropdown'>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=8.Donacion/donaciones.jsp'>Donaciones</a></li>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=1.TipoDonacion/unidadesDeMedida.jsp'>Unidades de Medida</a></li>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=1.TipoDonacion/tiposDonaciones.jsp'>Tipos de Donación</a></li>";
                menu += "</ul></li>";

                // Menú de Padripets
                menu += "<li class='nav-item dropdown'>";
                menu += "<a class='nav-link dropdown-toggle d-flex align-items-center' href='#' id='padripetsDropdown' role='button' data-bs-toggle='dropdown' aria-expanded='false' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/padrinos.png' alt='Padripets' width='23' height='23' class='me-2'> Padripets</a>";
                menu += "<ul class='dropdown-menu' aria-labelledby='padripetsDropdown'>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=6.PadriPets/padripets.jsp'>Padripets</a></li>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=2.TipoApadrinamiento/planesPadrinos.jsp'>Tipos de Padripet</a></li>";
                menu += "</ul></li>";

                // Menú de Adopciones
                menu += "<li class='nav-item dropdown'>";
                menu += "<a class='nav-link dropdown-toggle d-flex align-items-center' href='#' id='adopcionesDropdown' role='button' data-bs-toggle='dropdown' aria-expanded='false' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/adop.png' alt='Adopciones' width='24' height='24' class='me-2'> Adopciones</a>";
                menu += "<ul class='dropdown-menu' aria-labelledby='adopcionesDropdown'>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=7.Adopcion/adopciones.jsp'>Adopciones</a></li>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=7.Adopcion/verFormularioInfo.jsp'>Formularios de pre-adopción</a></li>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=7.Adopcion/verFormularioSeg.jsp'>Formularios de seguimientos</a></li>";
                menu += "</ul></li>";

                // Menú de Mascotas
                menu += "<li class='nav-item'><a class='nav-link d-flex align-items-center' href='principal.jsp?CONTENIDO=3.Mascotas/mascotas.jsp&nombre=" + getNombre() + "' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/mascota.png' alt='Mascotas' width='23' height='23' class='me-2'> Mascotas</a></li>";

                // Otros menús similares, ajustando el tamaño de fuente y espaciado
                menu += "<li class='nav-item'><a class='nav-link d-flex align-items-center' href='principal.jsp?CONTENIDO=4.Clientes/clientes.jsp&nombre=" + getNombre() + "' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/huella.png' alt='San Patitas' width='15' height='15' class='me-2'> San Patitas</a></li>";
                menu += "<li class='nav-item dropdown'>";
                menu += "<a class='nav-link dropdown-toggle' href='#' id='indicadoresDropdown' role='button' data-bs-toggle='dropdown' aria-expanded='false' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/indicador.png' alt='Indicadores' width='15' height='15' class='me-2'> Indicadores</a>";
                menu += "<ul class='dropdown-menu' aria-labelledby='indicadoresDropdown'>";

// Opción Donaciones con icono de donar
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=indicadores/donacionesXAnio.jsp'>";
                menu += "<img src='presentacion/imagenes/donar.png' alt='Icono Donaciones' width='18' height='18' class='me-2'> Donaciones</a></li>";

// Opción Apadrinamientos con icono de padrinos
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=indicadores/apadrinamientoXAnio.jsp'>";
                menu += "<img src='presentacion/imagenes/padrinos.png' alt='Icono Apadrinamientos' width='18' height='18' class='me-2'> Apadrinamientos</a></li>";

// Opción Adopciones con icono de adopciones
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=indicadores/adopcionesXAnio.jsp'>";
                menu += "<img src='presentacion/imagenes/adopciones.png' alt='Icono Adopciones' width='18' height='18' class='me-2'> Adopciones</a></li>";

// Opción Mascotas con icono de mascotas
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=indicadores/mascotasXAnio.jsp'>";
                menu += "<img src='presentacion/imagenes/mascota.png' alt='Icono Mascotas' width='18' height='18' class='me-2'> Mascotas</a></li>";

// Opción Cuidados con icono de calificaciones
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=indicadores/calificacionesXAnio.jsp'>";
                menu += "<img src='presentacion/imagenes/calificaciones.png' alt='Icono Cuidados' width='18' height='18' class='me-2'> Cuidados</a></li>";

                menu += "</ul></li>";
                // Perfil
                menu += "<li class='nav-item'><a class='nav-link d-flex align-items-center' href='principal.jsp?CONTENIDO=9.Perfil/perfilF.jsp' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/perfil.png' alt='Perfil' width='15' height='15' class='me-2'> Perfil</a></li>";
                menu += "<li class='nav-item'><a class='nav-link d-flex align-items-center' href='index.jsp' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>Salir</a></li>";

                menu += "</ul>";
                menu += "</div>";

                // Imagen del logo a la derecha
                menu += "<img src='presentacion/imagenes/Logo.png' alt='Logo' width='80' height='80' class='d-inline-block align-text-top'>";

                menu += "</div>";
                menu += "</nav>";
                break;
                
            case "S":
                menu += "<nav class='navbar navbar-expand-lg navbar-light transparent-navbar' 'style='padding: 50px 50px; width: 100%;'>"; // Añadido padding para mejor espacio
                menu += "<div class='container-fluid d-flex justify-content-between align-items-center'>";

                // Logo ajustado con mejor tamaño y centrado verticalmente
                menu += "<img src='presentacion/imagenes/Logo-Fundacion.png' alt='Logo' width='80' height='80' class='d-inline-block align-text-top me-3'>";

                // Botón para colapsar el menú en pantallas pequeñas
                menu += "<button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarNav' aria-controls='navbarNav' aria-expanded='false' aria-label='Toggle navigation'>";
                menu += "<span class='navbar-toggler-icon'></span>";
                menu += "</button>";

                // Menú desplegable y alineado a la derecha
                menu += "<div class='collapse navbar-collapse justify-content-center' id='navbarNav'>";
                menu += "<ul class='navbar-nav'>";

                // Enlaces del menú con mejor tamaño y espaciado
                menu += "<li class='nav-item'><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=inicio.jsp' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>Inicio</a></li>";

                // Menú de Donaciones
                menu += "<li class='nav-item dropdown'>";
                menu += "<a class='nav-link dropdown-toggle d-flex align-items-center' href='#' id='donacionesDropdown' role='button' data-bs-toggle='dropdown' aria-expanded='false' style='padding: 8px 10px; font-size: 0.9rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/donar.png' alt='Donaciones' width='23' height='23' class='me-2'> Donaciones</a>";
                menu += "<ul class='dropdown-menu' aria-labelledby='donacionesDropdown'>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=8.Donacion/donaciones.jsp'>Donaciones</a></li>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=1.TipoDonacion/unidadesDeMedida.jsp'>Unidades de Medida</a></li>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=1.TipoDonacion/tiposDonaciones.jsp'>Tipos de Donación</a></li>";
                menu += "</ul></li>";

                // Menú de Padripets
                menu += "<li class='nav-item dropdown'>";
                menu += "<a class='nav-link dropdown-toggle d-flex align-items-center' href='#' id='padripetsDropdown' role='button' data-bs-toggle='dropdown' aria-expanded='false' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/padrinos.png' alt='Padripets' width='23' height='23' class='me-2'> Padripets</a>";
                menu += "<ul class='dropdown-menu' aria-labelledby='padripetsDropdown'>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=6.PadriPets/padripets.jsp'>Padripets</a></li>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=2.TipoApadrinamiento/planesPadrinos.jsp'>Tipos de Padripet</a></li>";
                menu += "</ul></li>";

                // Menú de Adopciones
                menu += "<li class='nav-item dropdown'>";
                menu += "<a class='nav-link dropdown-toggle d-flex align-items-center' href='#' id='adopcionesDropdown' role='button' data-bs-toggle='dropdown' aria-expanded='false' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/adop.png' alt='Adopciones' width='24' height='24' class='me-2'> Adopciones</a>";
                menu += "<ul class='dropdown-menu' aria-labelledby='adopcionesDropdown'>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=7.Adopcion/adopciones.jsp'>Adopciones</a></li>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=7.Adopcion/verFormularioInfo.jsp'>Formularios de pre-adopción</a></li>";
                menu += "<li><a class='dropdown-item' href='principal.jsp?CONTENIDO=7.Adopcion/verFormularioSeg.jsp'>Formularios de seguimientos</a></li>";
                menu += "</ul></li>";

                // Menú de Mascotas
                menu += "<li class='nav-item'><a class='nav-link d-flex align-items-center' href='principal.jsp?CONTENIDO=3.Mascotas/mascotas.jsp&nombre=" + getNombre() + "' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/mascota.png' alt='Mascotas' width='23' height='23' class='me-2'> Mascotas</a></li>";

                // Otros menús similares, ajustando el tamaño de fuente y espaciado
                menu += "<li class='nav-item'><a class='nav-link d-flex align-items-center' href='principal.jsp?CONTENIDO=4.Clientes/clientes.jsp&nombre=" + getNombre() + "' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/huella.png' alt='San Patitas' width='15' height='15' class='me-2'> San Patitas</a></li>";
                menu += "<li class='nav-item'><a class='nav-link d-flex align-items-center' href='principal.jsp?CONTENIDO=5.Administradores/administradores.jsp' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/administrador.png' alt='Administradores' width='15' height='15' class='me-2'> Administradores</a></li>";
                menu += "<li class='nav-item dropdown'>";
                menu += "<a class='nav-link dropdown-toggle' href='#' id='indicadoresDropdown' role='button' data-bs-toggle='dropdown' aria-expanded='false' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/indicador.png' alt='Indicadores' width='15' height='15' class='me-2'> Indicadores</a>";
                menu += "<ul class='dropdown-menu' aria-labelledby='indicadoresDropdown'>";

// Opción Donaciones con icono de donar
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=indicadores/donacionesXAnio.jsp'>";
                menu += "<img src='presentacion/imagenes/donar.png' alt='Icono Donaciones' width='18' height='18' class='me-2'> Donaciones</a></li>";

// Opción Apadrinamientos con icono de padrinos
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=indicadores/apadrinamientoXAnio.jsp'>";
                menu += "<img src='presentacion/imagenes/padrinos.png' alt='Icono Apadrinamientos' width='18' height='18' class='me-2'> Apadrinamientos</a></li>";

// Opción Adopciones con icono de adopciones
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=indicadores/adopcionesXAnio.jsp'>";
                menu += "<img src='presentacion/imagenes/adopciones.png' alt='Icono Adopciones' width='18' height='18' class='me-2'> Adopciones</a></li>";

// Opción Mascotas con icono de mascotas
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=indicadores/mascotasXAnio.jsp'>";
                menu += "<img src='presentacion/imagenes/mascota.png' alt='Icono Mascotas' width='18' height='18' class='me-2'> Mascotas</a></li>";

// Opción Cuidados con icono de calificaciones
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=indicadores/calificacionesXAnio.jsp'>";
                menu += "<img src='presentacion/imagenes/calificaciones.png' alt='Icono Cuidados' width='18' height='18' class='me-2'> Cuidados</a></li>";

                menu += "</ul></li>";
                // Perfil
                menu += "<li class='nav-item'><a class='nav-link d-flex align-items-center' href='principal.jsp?CONTENIDO=9.Perfil/perfilF.jsp' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/perfil.png' alt='Perfil' width='15' height='15' class='me-2'> Perfil</a></li>";
                menu += "<li class='nav-item'><a class='nav-link d-flex align-items-center' href='index.jsp' style='padding: 8px 10px; font-size: 0.9rem;color: black; font-weight: bold;'>Salir</a></li>";

                menu += "</ul>";
                menu += "</div>";

                // Imagen del logo a la derecha
                menu += "<img src='presentacion/imagenes/Logo.png' alt='Logo' width='80' height='80' class='d-inline-block align-text-top'>";

                menu += "</div>";
                menu += "</nav>";
                break;

            case "C":
                menu += "<nav class='navbar navbar-expand-lg navbar-light transparent-navbar' 'style='padding: 50px 50px; width: 100%;'>"; // Añadido padding para mejor espacio
                menu += "<div class='container-fluid d-flex justify-content-between align-items-center'>";
// Imagen del logo a la izquierda
                menu += "<img src='presentacion/imagenes/Logo-Fundacion.png' alt='Logo' width='90' height='90' class='d-inline-block align-text-top'>";

// Botón para colapsar el menú en pantallas pequeñas
                menu += "<button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarNav' aria-controls='navbarNav' aria-expanded='false' aria-label='Toggle navigation'>";
                menu += "<span class='navbar-toggler-icon'></span>";
                menu += "</button>";

// Menú desplegable centrado
                menu += "<div class='collapse navbar-collapse justify-content-center' id='navbarNav'>";
                menu += "<ul class='navbar-nav'>";

// Opción "Inicio"
                menu += "<li class='nav-item'><a class='nav-link' href='principal.jsp?CONTENIDO=inicio.jsp' style='padding: 8px 20px; font-size: 1.2rem; color: black; font-weight: bold;'>Inicio</a></li>";

// Opción "Mascotas" con icono
                menu += "<li class='nav-item'><a class='nav-link' href='principal.jsp?CONTENIDO=3.Mascotas/mascotas.jsp&nombre=" + getNombre() + "' style='padding: 8px 20px; font-size: 1.2rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/mascota.png' alt='Icono Mascota' width='20' height='20' class='me-2'> Mascotas</a></li>";

// Opción "Adopciones" con icono
                menu += "<li class='nav-item'><a class='nav-link' href='principal.jsp?CONTENIDO=11.misAyudas/QuesonAdopciones.jsp&accion=Adicionar' style='padding: 8px 20px; font-size: 1.2rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/adop.png' alt='Icono Adopciones' width='20' height='20' class='me-2'> Adopciones</a></li>";

// Opción "Donaciones" con icono y estilo
                menu += "<li class='nav-item'><a class='nav-link' href='principal.jsp?CONTENIDO=11.misAyudas/QueSonDonaciones.jsp&accion=Adicionar' style='padding: 8px 20px; font-size: 1.2rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/donar.png' alt='Icono Donaciones' width='20' height='20' class='me-2'> Donaciones</a></li>";

// Opción "Padripet" con icono
                menu += "<li class='nav-item'><a class='nav-link' href='principal.jsp?CONTENIDO=11.misAyudas/QueSonPadrinos.jsp' style='padding: 8px 20px; font-size: 1.2rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/padrinos.png' alt='Icono Padripet' width='20' height='20' class='me-2'> Padripet</a></li>";

// Menú desplegable para "Tus Ayudas"
                menu += "<li class='nav-item dropdown position-relative'>";
                menu += "<a class='nav-link d-flex align-items-center' href='#' id='navbarDropdown' role='button' data-bs-toggle='dropdown' aria-expanded='false' style='padding: 8px 20px; font-size: 1.2rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/house.png' alt='Icono Casa' width='20' height='20' class='rounded-circle me-2'>";
                menu += "<span class='me-2'>Mis Ayudas</span>";
                menu += "<span class='dropdown-arrow'></span>";
                menu += "</a>";
                menu += "<ul class='dropdown-menu' aria-labelledby='navbarDropdown'>";

// Opción "Ver mis donaciones" con icono
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=11.misAyudas/verMisDonaciones.jsp' style='padding: 10px 15px; font-size: 1.2rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/donar.png' alt='Icono Donaciones' width='25' height='25' class='me-3'> <span class='ms-2'>Mis Donaciones</span></a></li>";

// Opción "Ver mis adopciones" con icono
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=11.misAyudas/verMisAdopciones.jsp' style='padding: 10px 15px; font-size: 1.2rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/adopciones.png' alt='Icono Adopciones' width='20' height='20' class='me-3'> <span class='ms-2'>Mis Adopciones</span></a></li>";

// Opción "Ver mis apadrinamientos" con icono
                menu += "<li><a class='dropdown-item d-flex align-items-center' href='principal.jsp?CONTENIDO=6.PadriPets/padripets.jsp' style='padding: 10px 15px; font-size: 1.2rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/apadrinamiento.png' alt='Icono Apadrinamientos' width='10' height='18' class='me-3'> <span class='ms-2'>Mis Apadrinamientos</span></a></li>";
                menu += "</ul>";
                menu += "</li>";

                // Opción "Perfil" con icono
                menu += "<li class='nav-item'><a class='nav-link' href='principal.jsp?CONTENIDO=9.Perfil/perfil.jsp' style='padding: 8px 20px; font-size: 1.2rem; color: black; font-weight: bold;'>";
                menu += "<img src='presentacion/imagenes/persona.png' alt='Icono Perfil' width='15' height='15' class='me-2'> Perfil</a></li>";

// Opción "Salir"
                menu += "<li class='nav-item'><a class='nav-link' href='index.jsp' style='padding: 10px 20px; font-size: 1.2rem; color: black; font-weight: bold;'>Salir</a></li>";

                menu += "</ul>";
                menu += "</div>";

// Imagen del logo a la derecha
                menu += "<img src='presentacion/imagenes/Logo.png' alt='Logo' width='80' height='80' class='d-inline-block align-text-top'>";

                menu += "</div>";
                menu += "</nav>";

        }

        menu += "</ul>";
        return menu;
    }

    public String getListaEnOptions() {
        String lista = "";
        switch (codigo) {
            case "S":
                lista = "<option value='S' selected>Administrador  Sistema</option><option value='F'>Administrador  Fundacion</option>";
                break;
            case "F":
                lista = "<option value='S'> Administrador  Sistema</option><option value='F' selected>Administrador  Fundacion</option>";
                break;
            case "C":
                lista = "<option value='S'> Administrador  Sistema</option><option value='F'>Administrador  Fundacion</option><option value='C' selected>Cliente</option>";
                break;
            default:
                lista = "<option value='S' selected> Administrador  Sistema</option><option value='F'>Administrador  Fundacion</option>";
                break;
        }
        return lista;

    }

}

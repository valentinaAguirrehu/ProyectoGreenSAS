/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Educacion {

   

    private String identificacion;
//    private String nivelEducativo;
//    private String fechaIngresoEmpresa;
    private String fechaEtapaLectiva;
    private String fechaFinalizacionEtapaLectiva;
    private String fechaEtapaProductiva;
    private String fechaFinalizacionEtapaProductiva;
    private String fechaRetiroAnticipado;
    private String tituloAprendiz;  // corregido nombre de atributo

    public Educacion() {
    }

    public Educacion(String identificacion) {
        String cadenaSQL = "SELECT * FROM educacion WHERE identificacion = '" + identificacion + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.identificacion = identificacion;
//                nivelEducativo = resultado.getString("nivelEducativo");
//                fechaIngresoEmpresa = resultado.getString("fechaIngresoEmpresa");
                fechaEtapaLectiva = resultado.getString("fechaEtapaLectiva");
                fechaFinalizacionEtapaLectiva = resultado.getString("fechaFinalizacionEtapaLectiva");
                fechaEtapaProductiva = resultado.getString("fechaEtapaProductiva");
                fechaFinalizacionEtapaProductiva = resultado.getString("fechaFinalizacionEtapaProductiva");
                fechaRetiroAnticipado = resultado.getString("fechaRetiroAnticipado");
                tituloAprendiz = resultado.getString("TituloAprendiz");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar educación: " + ex.getMessage());
        } finally {
            try {
                if (resultado != null) {
                    resultado.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar ResultSet de educación: " + ex.getMessage());
            }
        }
    }

    // Getters y Setters
    public String getIdentificacion() {
        return identificacion != null ? identificacion : "";
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }
//
//    public String getNivelEducativo() {
//        return nivelEducativo != null ? nivelEducativo : "";
//    }
//
//    public void setNivelEducativo(String nivelEducativo) {
//        this.nivelEducativo = nivelEducativo;
//    }

//    public String getFechaIngresoEmpresa() {
//        return fechaIngresoEmpresa != null ? fechaIngresoEmpresa : "";
//    }
//
//    public void setFechaIngresoEmpresa(String fechaIngresoEmpresa) {
//        this.fechaIngresoEmpresa = fechaIngresoEmpresa;
//    }
    public String getFechaEtapaLectiva() {
        return fechaEtapaLectiva != null ? fechaEtapaLectiva : "";
    }

    public void setFechaEtapaLectiva(String fechaEtapaLectiva) {
        this.fechaEtapaLectiva = fechaEtapaLectiva;
    }

    public String getFechaFinalizacionEtapaLectiva() {
        return fechaFinalizacionEtapaLectiva != null ? fechaFinalizacionEtapaLectiva : "";
    }

    public void setFechaFinalizacionEtapaLectiva(String fechaFinalizacionEtapaLectiva) {
        this.fechaFinalizacionEtapaLectiva = fechaFinalizacionEtapaLectiva;
    }

    public String getFechaEtapaProductiva() {
        return fechaEtapaProductiva != null ? fechaEtapaProductiva : "";
    }

    public void setFechaEtapaProductiva(String fechaEtapaProductiva) {
        this.fechaEtapaProductiva = fechaEtapaProductiva;
    }

    public String getFechaFinalizacionEtapaProductiva() {
        return fechaFinalizacionEtapaProductiva != null ? fechaFinalizacionEtapaProductiva : "";
    }

    public void setFechaFinalizacionEtapaProductiva(String fechaFinalizacionEtapaProductiva) {
        this.fechaFinalizacionEtapaProductiva = fechaFinalizacionEtapaProductiva;
    }

    public String getFechaRetiroAnticipado() {
        return fechaRetiroAnticipado != null ? fechaRetiroAnticipado : "";
    }

    public void setFechaRetiroAnticipado(String fechaRetiroAnticipado) {
        this.fechaRetiroAnticipado = fechaRetiroAnticipado;
    }

    public String getTituloAprendiz() {
        String resultado = tituloAprendiz;
        if (tituloAprendiz == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTituloAprendiz(String tituloAprendiz) {
        this.tituloAprendiz = tituloAprendiz;
    }

    @Override
    public String toString() {
        return identificacion != null ? identificacion : "";
    }

    public boolean grabar() {
        String cadenaSQL = "INSERT INTO educacion (identificacion, fechaEtapaLectiva, fechaFinalizacionEtapaLectiva, "
                + "fechaEtapaProductiva, fechaFinalizacionEtapaProductiva, fechaRetiroAnticipado, TituloAprendiz) VALUES ('"
                + identificacion + "', "
                + (fechaEtapaLectiva != null && !fechaEtapaLectiva.isEmpty() ? "'" + fechaEtapaLectiva + "'" : "NULL") + ", "
                + (fechaFinalizacionEtapaLectiva != null && !fechaFinalizacionEtapaLectiva.isEmpty() ? "'" + fechaFinalizacionEtapaLectiva + "'" : "NULL") + ", "
                + (fechaEtapaProductiva != null && !fechaEtapaProductiva.isEmpty() ? "'" + fechaEtapaProductiva + "'" : "NULL") + ", "
                + (fechaFinalizacionEtapaProductiva != null && !fechaFinalizacionEtapaProductiva.isEmpty() ? "'" + fechaFinalizacionEtapaProductiva + "'" : "NULL") + ", "
                + (fechaRetiroAnticipado != null && !fechaRetiroAnticipado.isEmpty() ? "'" + fechaRetiroAnticipado + "'" : "NULL") + ", "
                + (tituloAprendiz != null && !tituloAprendiz.isEmpty() ? "'" + tituloAprendiz.replace("'", "''") + "'" : "NULL")
                + ");";

        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);
        System.out.println("Consulta SQL: " + cadenaSQL);

        if (!resultado) {
            System.out.println("Error: No se pudo insertar la educacion en la BD");
            return false;
        }
        return true;
    }

    public boolean modificar(String identificacionAnterior) {
        if (identificacion == null || identificacionAnterior == null || identificacionAnterior.trim().isEmpty()) {
            System.out.println("Error: identificacion o identificacionAnterior es null o vacío.");
            return false;
        }

        String cadenaSQL = "UPDATE educacion SET "
                + "identificacion='" + identificacion + "', "
                + "fechaEtapaLectiva=" + (fechaEtapaLectiva != null && !fechaEtapaLectiva.isEmpty() ? "'" + fechaEtapaLectiva + "'" : "NULL") + ", "
                + "fechaFinalizacionEtapaLectiva=" + (fechaFinalizacionEtapaLectiva != null && !fechaFinalizacionEtapaLectiva.isEmpty() ? "'" + fechaFinalizacionEtapaLectiva + "'" : "NULL") + ", "
                + "fechaEtapaProductiva=" + (fechaEtapaProductiva != null && !fechaEtapaProductiva.isEmpty() ? "'" + fechaEtapaProductiva + "'" : "NULL") + ", "
                + "fechaFinalizacionEtapaProductiva=" + (fechaFinalizacionEtapaProductiva != null && !fechaFinalizacionEtapaProductiva.isEmpty() ? "'" + fechaFinalizacionEtapaProductiva + "'" : "NULL") + ", "
                + "fechaRetiroAnticipado=" + (fechaRetiroAnticipado != null && !fechaRetiroAnticipado.isEmpty() ? "'" + fechaRetiroAnticipado + "'" : "NULL") + ", "
                + "TituloAprendiz=" + (tituloAprendiz != null && !tituloAprendiz.isEmpty() ? "'" + tituloAprendiz.replace("'", "''") + "'" : "NULL") + " "
                + "WHERE identificacion='" + identificacionAnterior + "'";

        System.out.println("Consulta SQL de modificación: " + cadenaSQL);
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar() {
        String cadenaSQL = "DELETE FROM educacion WHERE identificacion = '" + identificacion + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static ResultSet getLista(String filtro, String orden) {
        filtro = (filtro != null && !filtro.isEmpty()) ? " WHERE " + filtro : "";
        orden = (orden != null && !orden.isEmpty()) ? " ORDER BY " + orden : "";

        String cadenaSQL = "SELECT identificacion, "
                + "fechaEtapaLectiva, fechaFinalizacionEtapaLectiva, fechaEtapaProductiva, "
                + "fechaFinalizacionEtapaProductiva, fechaRetiroAnticipado, TituloAprendiz "
                + "FROM educacion " + filtro + orden;

        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Educacion> getListaEnObjetos(String filtro, String orden) {
        List<Educacion> lista = new ArrayList<>();
        ResultSet resultado = getLista(filtro, orden);

        try {
            while (resultado.next()) {
                Educacion educacion = new Educacion();
                educacion.setIdentificacion(resultado.getString("identificacion"));
//                educacion.setNivelEducativo(resultado.getString("nivelEducativo"));
//                educacion.setFechaIngresoEmpresa(resultado.getString("fechaIngresoEmpresa"));
                educacion.setFechaEtapaLectiva(resultado.getString("fechaEtapaLectiva"));
                educacion.setFechaFinalizacionEtapaLectiva(resultado.getString("fechaFinalizacionEtapaLectiva"));
                educacion.setFechaEtapaProductiva(resultado.getString("fechaEtapaProductiva"));
                educacion.setFechaFinalizacionEtapaProductiva(resultado.getString("fechaFinalizacionEtapaProductiva"));
                educacion.setFechaRetiroAnticipado(resultado.getString("fechaRetiroAnticipado"));
                educacion.setTituloAprendiz(resultado.getString("TituloAprendiz"));
                lista.add(educacion);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Educacion.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (resultado != null) {
                    resultado.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(Educacion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return lista;
    }

    public static List<String[]> getListaEnArreglosJS(String filtro, String orden) throws SQLException {
        List<String[]> lista = new ArrayList<>();
        try (ResultSet datos = Educacion.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    String[] educacion = new String[]{
                        datos.getString("identificacion"),
                        //                        datos.getString("nivelEducativo"),
                        //                        datos.getString("fechaIngresoEmpresa"),
                        datos.getString("fechaEtapaLectiva"),
                        datos.getString("fechaFinalizacionEtapaLectiva"),
                        datos.getString("fechaEtapaProductiva"),
                        datos.getString("fechaFinalizacionEtapaProductiva"),
                        datos.getString("fechaRetiroAnticipado"),
                        datos.getString("TituloAprendiz")
                    };
                    lista.add(educacion);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Educacion.class.getName()).log(Level.SEVERE, "Error al obtener lista de educación en arreglo JS", e);
        }
        return lista;
    }

//    public static boolean esNivelEducativoPredefinido(String nivel) {
//        return nivel != null && (nivel.equals("Primaria") || nivel.equals("Secundaria")
//                || nivel.equals("Tecnico") || nivel.equals("Tecnologico")
//                || nivel.equals("Universitario") || nivel.equals("Postgrado"));
//    }
    public static Educacion getInformacionPorIdentificacion(String identificacion) {
        Educacion educacion = null;
        String sql = "SELECT identificacion, fechaEtapaLectiva, fechaFinalizacionEtapaLectiva, fechaEtapaProductiva, fechaFinalizacionEtapaProductiva, fechaRetiroAnticipado, TituloAprendiz FROM educacion WHERE identificacion = '" + identificacion + "'";

        try {
            ResultSet rs = ConectorBD.consultar(sql);
            if (rs != null && rs.next()) {
                educacion = new Educacion();
                educacion.setIdentificacion(rs.getString("identificacion"));
//            educacion.setNivelEducativo(rs.getString("nivelEducativo"));
//            educacion.setFechaIngresoEmpresa(rs.getString("fechaIngresoEmpresa"));
                educacion.setFechaEtapaLectiva(rs.getString("fechaEtapaLectiva"));
                educacion.setFechaFinalizacionEtapaLectiva(rs.getString("fechaFinalizacionEtapaLectiva"));
                educacion.setFechaEtapaProductiva(rs.getString("fechaEtapaProductiva"));
                educacion.setFechaFinalizacionEtapaProductiva(rs.getString("fechaFinalizacionEtapaProductiva"));
                educacion.setFechaRetiroAnticipado(rs.getString("fechaRetiroAnticipado"));
                educacion.setTituloAprendiz(rs.getString("TituloAprendiz"));
            }
        } catch (Exception e) {
            System.out.println("❌ Error al consultar educación: " + e.getMessage());
        }

        return educacion;
    }

    public static String getFechaEtapaLectiva(String identificacionPersona) {
        String sql = "SELECT fechaEtapaLectiva FROM educacion WHERE identificacion = '" + identificacionPersona + "'";

        try {
            ResultSet rs = ConectorBD.consultar(sql);
            if (rs.next()) {
                return rs.getString("fechaEtapaLectiva"); // Devuelve la fecha directamente
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ""; // Si no tiene fecha, devuelve cadena vacía
    }
    public static String getFechaEtapaProductiva(String identificacionPersona) {
        String sql = "SELECT fechaEtapaProductiva FROM educacion WHERE identificacion = '" + identificacionPersona + "'";

        try {
            ResultSet rs = ConectorBD.consultar(sql);
            if (rs.next()) {
                return rs.getString("fechaEtapaProductiva"); // Devuelve la fecha directamente
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ""; // Si no tiene fecha, devuelve cadena vacía
    }
public static String getEtapaProductivaPorIdentificacion(String identificacion) {
    if (identificacion == null || identificacion.trim().isEmpty()) {
        return "";
    }

    try {
        Educacion edu = new Educacion(identificacion);
        return (edu.getFechaEtapaProductiva() != null) ? edu.getFechaEtapaProductiva() : "";
    } catch (Exception e) {
        System.out.println("❌ Error al obtener etapa productiva: " + e.getMessage());
        return "";
    }
}

}

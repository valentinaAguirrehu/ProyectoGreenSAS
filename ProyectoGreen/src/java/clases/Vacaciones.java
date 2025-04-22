package clases;

import clasesGenericas.ConectorBD;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class Vacaciones {

    private String idVacaciones;
    private String idPersona;
    private String periodoDisfrute;
    private String periodoDisfruteFin;
    private String diasDisfrutados;
    private String diasCompensados;
    private String diasCompensar;
    private String observacion;

    public Vacaciones() {
    }

    public Vacaciones(String idVacaciones) {
        String consultaSQL = "SELECT idVacaciones, Id_persona, periodoDisfrute, periodoDisfruteFin, diasDisfrutados, diasCompensados, diasCompensar, observacion "
                + "FROM vacaciones WHERE idVacaciones = '" + idVacaciones + "'";
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        try {
            if (resultado.next()) {
                this.idVacaciones = idVacaciones;
                idPersona = resultado.getString("Id_persona");
                periodoDisfrute = resultado.getString("periodoDisfrute");
                periodoDisfruteFin = resultado.getString("periodoDisfruteFin");
                diasDisfrutados = resultado.getString("diasDisfrutados");
                diasCompensados = resultado.getString("diasCompensados");
                diasCompensar = resultado.getString("diasCompensar");
                observacion = resultado.getString("observacion");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el ID: " + ex.getMessage());
        }
    }

    // Getters y setters...
    public String getIdVacaciones() {
        return idVacaciones;
    }

    public void setIdVacaciones(String idVacaciones) {
        this.idVacaciones = idVacaciones;
    }

    public String getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(String idPersona) {
        this.idPersona = idPersona;
    }

    public String getPeriodoDisfrute() {
        return periodoDisfrute;
    }

    public void setPeriodoDisfrute(String periodoDisfrute) {
        this.periodoDisfrute = periodoDisfrute;
    }

    public String getPeriodoDisfruteFin() {
        return periodoDisfruteFin;
    }

    public void setPeriodoDisfruteFin(String periodoDisfruteFin) {
        this.periodoDisfruteFin = periodoDisfruteFin;
    }

    public String getDiasDisfrutados() {
        return diasDisfrutados;
    }

    public void setDiasDisfrutados(String diasDisfrutados) {
        this.diasDisfrutados = diasDisfrutados;
    }

    public String getDiasCompensados() {
        return diasCompensados;
    }

    public void setDiasCompensados(String diasCompensados) {
        this.diasCompensados = diasCompensados;
    }

    public String getDiasCompensar() {
        return diasCompensar;
    }

    public void setDiasCompensar(String diasCompensar) {
        this.diasCompensar = diasCompensar;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

public boolean grabar() {
    // Primero, obtener la fecha de ingreso de la persona desde la base de datos (asumo que tienes un método para obtenerla)
    String consultaFechaIngreso = "SELECT fechaIngreso FROM persona WHERE identificacion = '" + idPersona + "'";
    ResultSet rsFechaIngreso = ConectorBD.consultar(consultaFechaIngreso);
    Date fechaIngreso = null;

    try {
        if (rsFechaIngreso.next()) {
            fechaIngreso = rsFechaIngreso.getDate("fechaIngreso");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Calcular los días restantes
    int diasDisfrutadosInt = Integer.parseInt(diasDisfrutados);
    int diasRestantes = calcularVacacionesAcumuladas(fechaIngreso, diasDisfrutadosInt);

    // Si los días disfrutados no superan los días acumulados
    if (diasRestantes >= 0) {
        // Realizar la inserción solo si los días disfrutados no superan los días acumulados
        String consultaSQL = "INSERT INTO vacaciones (Id_persona, periodoDisfrute, periodoDisfruteFin, diasDisfrutados, diasCompensados, diasCompensar, observacion) VALUES ("
                + "'" + idPersona + "', "
                + (periodoDisfrute != null && !periodoDisfrute.trim().isEmpty() ? "'" + periodoDisfrute + "'" : "NULL") + ", "
                + (periodoDisfruteFin != null && !periodoDisfruteFin.trim().isEmpty() ? "'" + periodoDisfruteFin + "'" : "NULL") + ", "
                + "'" + diasDisfrutados + "', "
                + (diasCompensados != null && !diasCompensados.trim().isEmpty() ? "'" + diasCompensados + "'" : "NULL") + ", "
                + "'" + diasCompensar + "', "
                + "'" + observacion + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    } else {
        // Si los días disfrutados son mayores que los acumulados
        System.out.println("Error: no puedes disfrutar más días de vacaciones de los acumulados.");
        return false;
    }
}


    // Método para modificar una entrada existente
    public boolean modificar(String idAnterior) {
        String consultaSQL = "UPDATE vacaciones SET "
                + "Id_persona = '" + idPersona + "', "
                + "periodoDisfrute = " + (periodoDisfrute != null && !periodoDisfrute.trim().isEmpty() ? "'" + periodoDisfrute + "'" : "NULL") + ", "
                + "periodoDisfruteFin = " + (periodoDisfruteFin != null && !periodoDisfruteFin.trim().isEmpty() ? "'" + periodoDisfruteFin + "'" : "NULL") + ", "
                + "diasDisfrutados = '" + diasDisfrutados + "', "
                + "diasCompensados = " + (diasCompensados != null && !diasCompensados.trim().isEmpty() ? "'" + diasCompensados + "'" : "NULL") + ", "
                + "diasCompensar = '" + diasCompensar + "', "
                + "observacion = '" + observacion + "' "
                + "WHERE idVacaciones = '" + idAnterior + "'";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    // Método para eliminar una entrada
    public boolean eliminar(String id) {
        String consultaSQL = "DELETE FROM vacaciones WHERE idVacaciones = '" + id + "'";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    // Método para obtener todas las vacaciones
    public static ResultSet getLista() {
        String consultaSQL = "SELECT v.idVacaciones, v.Id_persona, v.periodoDisfrute, v.periodoDisfruteFin, v.diasDisfrutados, v.diasCompensados, "
                + "v.diasCompensar, v.observacion, p.nombres, p.apellidos, p.fechaIngreso "
                + "FROM vacaciones v "
                + "JOIN persona p ON v.Id_persona = p.identificacion";
        return ConectorBD.consultar(consultaSQL);
    }

    // Obtener lista como objetos
    public static List<Vacaciones> getListaEnObjetos(String filtro, String orden) {
        List<Vacaciones> lista = new ArrayList<>();
        String consultaSQL = "SELECT idVacaciones, Id_persona, periodoDisfrute, periodoDisfruteFin, diasDisfrutados, diasCompensados, diasCompensar, observacion FROM vacaciones";

        if (filtro != null && !filtro.isEmpty()) {
            consultaSQL += " WHERE " + filtro;
        }
        if (orden != null && !orden.isEmpty()) {
            consultaSQL += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(consultaSQL);
        try {
            if (rs != null) {
                while (rs.next()) {
                    Vacaciones v = new Vacaciones();
                    v.setIdVacaciones(rs.getString("idVacaciones"));
                    v.setIdPersona(rs.getString("Id_persona"));
                    v.setPeriodoDisfrute(rs.getString("periodoDisfrute"));
                    v.setPeriodoDisfruteFin(rs.getString("periodoDisfruteFin"));
                    v.setDiasDisfrutados(rs.getString("diasDisfrutados"));
                    v.setDiasCompensados(rs.getString("diasCompensados"));
                    v.setDiasCompensar(rs.getString("diasCompensar"));
                    v.setObservacion(rs.getString("observacion"));
                    lista.add(v);
                }
                rs.close();
            } else {
                System.out.println(" El ResultSet es null. Verifica la consulta SQL: " + consultaSQL);
            }
        } catch (SQLException ex) {
            System.out.println(" Error al obtener lista de vacaciones: " + ex.getMessage());
        }

        return lista;
    }

  public int calcularVacacionesAcumuladas(Date fechaIngreso, int diasDisfrutados) {
    // Obtener la fecha actual y la fecha de ingreso como Calendar
    Calendar fechaActual = Calendar.getInstance();
    Calendar fechaIngresoCalendar = Calendar.getInstance();
    fechaIngresoCalendar.setTime(fechaIngreso);

    // Calcular la diferencia en años completos entre la fecha de ingreso y la fecha actual
    int aniosDeTrabajo = fechaActual.get(Calendar.YEAR) - fechaIngresoCalendar.get(Calendar.YEAR);

    // Verificar si el año aún no ha cumplido el ciclo completo (mes y día)
    if (fechaActual.get(Calendar.MONTH) < fechaIngresoCalendar.get(Calendar.MONTH)
            || (fechaActual.get(Calendar.MONTH) == fechaIngresoCalendar.get(Calendar.MONTH)
                && fechaActual.get(Calendar.DAY_OF_MONTH) < fechaIngresoCalendar.get(Calendar.DAY_OF_MONTH))) {
        aniosDeTrabajo--; // Restar 1 si no ha cumplido el ciclo anual completo
    }

    // Calcular los días acumulados: 15 días por cada año completo de trabajo
    int diasAcumulados = 0;
    if (aniosDeTrabajo >= 1) {
        diasAcumulados = 15 * aniosDeTrabajo; // 15 días por cada año completo trabajado
    }

    // Validar los días disfrutados: no puede disfrutar más días de los acumulados
    if (diasDisfrutados > diasAcumulados) {
        diasDisfrutados = diasAcumulados; // Ajustar los días disfrutados a los días acumulados
    }

    // Devolver los días restantes de vacaciones (días acumulados - días disfrutados)
    return diasAcumulados - diasDisfrutados;
}
}
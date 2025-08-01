
package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author asosa
 */
@Entity
@Table(name="DetalleUsuarios")
public class DetalleUsuario {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="idDetalleUsuario")
    private int idDetalleUsuario;
    
    @Column(name="direccionUsuario")
    private String direccionUsuario;
    
    @Column(name="puestoUsuario")
    private String puestoUsuario;
    
    @Column(name="salarioUsuario")
    private double salarioUsuario;
    
    @Column(name="idUsuario")
    private int idUsuario;

    public DetalleUsuario() {
    }

    public DetalleUsuario(int idDetalleUsuario, String direccionUsuario, String puestoUsuario, double salarioUsuario, int idUsuario) {
        this.idDetalleUsuario = idDetalleUsuario;
        this.direccionUsuario = direccionUsuario;
        this.puestoUsuario = puestoUsuario;
        this.salarioUsuario = salarioUsuario;
        this.idUsuario = idUsuario;
    }

    public DetalleUsuario(String direccionUsuario, String puestoUsuario, double salarioUsuario, int idUsuario) {
        this.direccionUsuario = direccionUsuario;
        this.puestoUsuario = puestoUsuario;
        this.salarioUsuario = salarioUsuario;
        this.idUsuario = idUsuario;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdDetalleUsuario() {
        return idDetalleUsuario;
    }

    public void setIdDetalleUsuario(int idDetalleUsuario) {
        this.idDetalleUsuario = idDetalleUsuario;
    }

    public String getDireccionUsuario() {
        return direccionUsuario;
    }

    public void setDireccionUsuario(String direccionUsuario) {
        this.direccionUsuario = direccionUsuario;
    }

    public String getPuestoUsuario() {
        return puestoUsuario;
    }

    public void setPuestoUsuario(String puestoUsuario) {
        this.puestoUsuario = puestoUsuario;
    }

    public double getSalarioUsuario() {
        return salarioUsuario;
    }

    public void setSalarioUsuario(double salarioUsuario) {
        this.salarioUsuario = salarioUsuario;
    }
}

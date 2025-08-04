package model;

import java.sql.Timestamp;
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
@Table(name = "Compras")
public class Compra {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCompra")
    private int idCompra;

    @Column(name = "estadoCompra")
    private String estadoCompra;

    @Column(name = "fechaCompra")
    private Timestamp fechaCompra;

    @Column(name = "idUsuario")
    private int idUsuario;

    public Compra() {
    }

    public Compra(int idCompra, String estadoCompra, Timestamp fechaCompra, int idUsuario) {
        this.idCompra = idCompra;
        this.estadoCompra = estadoCompra;
        this.fechaCompra = fechaCompra;
        this.idUsuario = idUsuario;
    }

    public Compra(String estadoCompra, Timestamp fechaCompra, int idUsuario) {
        this.estadoCompra = estadoCompra;
        this.fechaCompra = fechaCompra;
        this.idUsuario = idUsuario;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public String getEstadoCompra() {
        return estadoCompra;
    }

    public void setEstadoCompra(String estadoCompra) {
        this.estadoCompra = estadoCompra;
    }


    public Timestamp getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(Timestamp fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
}

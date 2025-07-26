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

    @Column(name = "estadoPago")
    private String estadoPago;

    @Column(name = "fechaCompra")
    private Timestamp fechaCompra;

    @Column(name = "idCliente")
    private int idCliente;

    public Compra() {
    }

    public Compra(int idCompra, String estadoCompra, String estadoPago, Timestamp fechaCompra, int idCliente) {
        this.idCompra = idCompra;
        this.estadoCompra = estadoCompra;
        this.estadoPago = estadoPago;
        this.fechaCompra = fechaCompra;
        this.idCliente = idCliente;
    }

    public Compra(String estadoCompra, String estadoPago, Timestamp fechaCompra, int idCliente) {
        this.estadoCompra = estadoCompra;
        this.estadoPago = estadoPago;
        this.fechaCompra = fechaCompra;
        this.idCliente = idCliente;
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

    public String getEstadoPago() {
        return estadoPago;
    }

    public void setEstadoPago(String estadoPago) {
        this.estadoPago = estadoPago;
    }

    public Timestamp getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(Timestamp fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }
}

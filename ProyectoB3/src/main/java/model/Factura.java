
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
@Table(name = "Facturas")
public class Factura {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idFactura")
    private int idFactura;

    @Column(name = "fechaFactura")
    private Timestamp fechaFactura;

    @Column(name = "total")
    private double total;

    @Column(name = "metodoPago")
    private String metodoPago;

    @Column(name = "idCompra")
    private int idCompra;

    public Factura() {
    }

    public Factura(int idFactura, Timestamp fechaFactura, double total, String metodoPago, int idCompra) {
        this.idFactura = idFactura;
        this.fechaFactura = fechaFactura;
        this.total = total;
        this.metodoPago = metodoPago;
        this.idCompra = idCompra;
    }

    public Factura(Timestamp fechaFactura, double total, String metodoPago, int idCompra) {
        this.fechaFactura = fechaFactura;
        this.total = total;
        this.metodoPago = metodoPago;
        this.idCompra = idCompra;
    }

    public int getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(int idFactura) {
        this.idFactura = idFactura;
    }

    public Timestamp getFechaFactura() {
        return fechaFactura;
    }

    public void setFechaFactura(Timestamp fechaFactura) {
        this.fechaFactura = fechaFactura;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }
}


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
@Table(name = "Pagos")
public class Pago {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPago")
    private int idPago;

    @Column(name = "fechaPago")
    private Timestamp fechaPago;

    @Column(name = "metodoPago")
    private String metodoPago;

    @Column(name = "cantidadPago")
    private double cantidadPago;

    @Column(name = "idCompra")
    private int idCompra;

    public Pago() {
    }

    public Pago(int idPago, Timestamp fechaPago, String metodoPago, double cantidadPago, int idCompra) {
        this.idPago = idPago;
        this.fechaPago = fechaPago;
        this.metodoPago = metodoPago;
        this.cantidadPago = cantidadPago;
        this.idCompra = idCompra;
    }

    public Pago(Timestamp fechaPago, String metodoPago, double cantidadPago, int idCompra) {
        this.fechaPago = fechaPago;
        this.metodoPago = metodoPago;
        this.cantidadPago = cantidadPago;
        this.idCompra = idCompra;
    }

    public int getIdPago() {
        return idPago;
    }

    public void setIdPago(int idPago) {
        this.idPago = idPago;
    }

    public Timestamp getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(Timestamp fechaPago) {
        this.fechaPago = fechaPago;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public double getCantidadPago() {
        return cantidadPago;
    }

    public void setCantidadPago(double cantidadPago) {
        this.cantidadPago = cantidadPago;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }
}

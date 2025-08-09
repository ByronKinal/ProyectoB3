package model;

import java.sql.Timestamp;
import javax.persistence.*;

@Entity
@Table(name = "Pagos")
public class Pago {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPago")
    private int idPago;
    
    @Column(name = "fechaPago")
    private Timestamp fechaPago;
    
    @Column(name = "estadoPago")
    private String estadoPago;
    
    @Column(name = "metodoPago")
    private String metodoPago;
    
    @OneToOne
    @JoinColumn(name = "idCompra", referencedColumnName = "idCompra")
    private Compra compra;

    public Pago() {
    }

    public Pago(Timestamp fechaPago, String estadoPago, String metodoPago, Compra compra) {
        this.fechaPago = fechaPago;
        this.estadoPago = estadoPago;
        this.metodoPago = metodoPago;
        this.compra = compra;
    }

    // Getters y Setters
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

    public String getEstadoPago() {
        return estadoPago;
    }

    public void setEstadoPago(String estadoPago) {
        this.estadoPago = estadoPago;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public Compra getCompra() {
        return compra;
    }

    public void setCompra(Compra compra) {
        this.compra = compra;
    }
}
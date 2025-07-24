/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
@Table(name = "Facturas")
public class Factura {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "idFactura")
    private int idFactura;

    @Column(name = "fechaFactura")
    private int fechaFactura;

    @Column(name = "total")
    private int total;

    @Column(name = "metodoPago")
    private int metodoPago;

    @Column(name = "idCliente")
    private int idCliente;

    @Column(name = "idCompra")
    private int idCompra;
    @Column(name = "idPago")
    private int idPago;

    public Factura(int idFactura, int fechaFactura, int total, int metodoPago, int idCliente, int idCompra, int idPago) {
        this.idFactura = idFactura;
        this.fechaFactura = fechaFactura;
        this.total = total;
        this.metodoPago = metodoPago;
        this.idCliente = idCliente;
        this.idCompra = idCompra;
        this.idPago = idPago;
    }

    public Factura(int fechaFactura, int total, int metodoPago, int idCliente, int idCompra, int idPago) {
        this.fechaFactura = fechaFactura;
        this.total = total;
        this.metodoPago = metodoPago;
        this.idCliente = idCliente;
        this.idCompra = idCompra;
        this.idPago = idPago;
    }

    public Factura() {
    }

    public int getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(int idFactura) {
        this.idFactura = idFactura;
    }

    public int getFechaFactura() {
        return fechaFactura;
    }

    public void setFechaFactura(int fechaFactura) {
        this.fechaFactura = fechaFactura;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(int metodoPago) {
        this.metodoPago = metodoPago;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public int getIdPago() {
        return idPago;
    }

    public void setIdPago(int idPago) {
        this.idPago = idPago;
    }

  
}

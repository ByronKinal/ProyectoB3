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
@Table(name = "Pagos")
public class Pago {
    




    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "idPago")
    private int idPago;

    @Column(name = "fechaPago")
    private int fechaPago;

    @Column(name = "metodoPago")
    private int metodoPago;

    @Column(name = "cantidadPago")
    private int cantidadPago;

    @Column(name = "idCompra")
    private int idCompra;

    public Pago() {
    }

    public Pago(int idPago, int fechaPago, int metodoPago, int cantidadPago, int idCompra) {
        this.idPago = idPago;
        this.fechaPago = fechaPago;
        this.metodoPago = metodoPago;
        this.cantidadPago = cantidadPago;
        this.idCompra = idCompra;
    }

    public Pago(int fechaPago, int metodoPago, int cantidadPago, int idCompra) {
        this.fechaPago = fechaPago;
        this.metodoPago = metodoPago;
        this.cantidadPago = cantidadPago;
        this.idCompra = idCompra;
    }

    public int getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(int fechaPago) {
        this.fechaPago = fechaPago;
    }

    public int getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(int metodoPago) {
        this.metodoPago = metodoPago;
    }

    public int getCantidadPago() {
        return cantidadPago;
    }

    public void setCantidadPago(int cantidadPago) {
        this.cantidadPago = cantidadPago;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }


 

}

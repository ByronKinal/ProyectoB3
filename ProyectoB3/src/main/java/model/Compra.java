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
@Table(name = "Compras")
public class Compra {
    

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "idCompra")
    private int idCompra;

    @Column(name = "estadoCompra")
    private int estadoCompra;

    @Column(name = "estadoPago")
    private int estadoPago;

    @Column(name = "fechaCompra")
    private int fechaCompra;

    @Column(name = "idCliente")
    private int idCliente;

    public Compra(int idCompra, int estadoCompra, int estadoPago, int fechaCompra, int idCliente) {
        this.idCompra = idCompra;
        this.estadoCompra = estadoCompra;
        this.estadoPago = estadoPago;
        this.fechaCompra = fechaCompra;
        this.idCliente = idCliente;
    }

    public Compra(int estadoCompra, int estadoPago, int fechaCompra, int idCliente) {
        this.estadoCompra = estadoCompra;
        this.estadoPago = estadoPago;
        this.fechaCompra = fechaCompra;
        this.idCliente = idCliente;
    }

    
   

    public Compra() {
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public int getEstadoCompra() {
        return estadoCompra;
    }

    public void setEstadoCompra(int estadoCompra) {
        this.estadoCompra = estadoCompra;
    }

    public int getEstadoPago() {
        return estadoPago;
    }

    public void setEstadoPago(int estadoPago) {
        this.estadoPago = estadoPago;
    }

    public int getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(int fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }


    
    }

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
@Table(name = "Carritos")
public class Carrito {
    


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "idCompra")
    private int idCompra;

    @Column(name = "idProducto")
    private int idProducto;

    @Column(name = "cantidadProducto")
    private int cantidadProducto;

    @Column(name = "subtotal")
    private int subtotal;

    public Carrito(int idCompra, int idProducto, int cantidadProducto, int subtotal) {
        this.idCompra = idCompra;
        this.idProducto = idProducto;
        this.cantidadProducto = cantidadProducto;
        this.subtotal = subtotal;
    }

    public Carrito() {
    }

    public Carrito(int idProducto, int cantidadProducto, int subtotal) {
        this.idProducto = idProducto;
        this.cantidadProducto = cantidadProducto;
        this.subtotal = subtotal;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getCantidadProducto() {
        return cantidadProducto;
    }

    public void setCantidadProducto(int cantidadProducto) {
        this.cantidadProducto = cantidadProducto;
    }

    public int getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(int subtotal) {
        this.subtotal = subtotal;
    }

  

}

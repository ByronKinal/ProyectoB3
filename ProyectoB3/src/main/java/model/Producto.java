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
@Table(name = "Productos")
public class Producto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "idProducto")
    private int idProducto;

    @Column(name = "nombreProducto")
    private int nombreProducto;

    @Column(name = "descripcionProducto")
    private int descripcionProducto;

    @Column(name = "tallaProducto")
    private int tallaProducto;

    @Column(name = "marcaProducto")
    private int marcaProducto;
    @Column(name = "precioProducto")
    private int precioProducto;
    @Column(name = "stockProducto")
    private int stockProducto;
    @Column(name = "idCategoria")
    private int idCategoria;
    @Column(name = "idProveedor")
    private int idProveedor;

    public Producto() {
    }

    public Producto(int idProducto, int nombreProducto, int descripcionProducto, int tallaProducto, int marcaProducto, int precioProducto, int stockProducto, int idCategoria, int idProveedor) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.descripcionProducto = descripcionProducto;
        this.tallaProducto = tallaProducto;
        this.marcaProducto = marcaProducto;
        this.precioProducto = precioProducto;
        this.stockProducto = stockProducto;
        this.idCategoria = idCategoria;
        this.idProveedor = idProveedor;
    }

    public Producto(int nombreProducto, int descripcionProducto, int tallaProducto, int marcaProducto, int precioProducto, int stockProducto, int idCategoria, int idProveedor) {
        this.nombreProducto = nombreProducto;
        this.descripcionProducto = descripcionProducto;
        this.tallaProducto = tallaProducto;
        this.marcaProducto = marcaProducto;
        this.precioProducto = precioProducto;
        this.stockProducto = stockProducto;
        this.idCategoria = idCategoria;
        this.idProveedor = idProveedor;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(int nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public int getDescripcionProducto() {
        return descripcionProducto;
    }

    public void setDescripcionProducto(int descripcionProducto) {
        this.descripcionProducto = descripcionProducto;
    }

    public int getTallaProducto() {
        return tallaProducto;
    }

    public void setTallaProducto(int tallaProducto) {
        this.tallaProducto = tallaProducto;
    }

    public int getMarcaProducto() {
        return marcaProducto;
    }

    public void setMarcaProducto(int marcaProducto) {
        this.marcaProducto = marcaProducto;
    }

    public int getPrecioProducto() {
        return precioProducto;
    }

    public void setPrecioProducto(int precioProducto) {
        this.precioProducto = precioProducto;
    }

    public int getStockProducto() {
        return stockProducto;
    }

    public void setStockProducto(int stockProducto) {
        this.stockProducto = stockProducto;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    
}

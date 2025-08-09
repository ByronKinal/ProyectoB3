package model;

import javax.persistence.*;

@Entity
@Table(name = "Carritos")
public class Carrito {
    @EmbeddedId
    private CarritoId id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idCompra")
    @JoinColumn(name = "idCompra", referencedColumnName = "idCompra")
    private Compra compra;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idProducto")
    @JoinColumn(name = "idProducto", referencedColumnName = "idProducto")
    private Producto producto;
    
    @Column(name = "cantidadProducto")
    private int cantidadProducto;
    
    @Column(name = "subtotal")
    private double subtotal;

    public Carrito() {
    }

    public Carrito(Compra compra, Producto producto, int cantidadProducto, double subtotal) {
        this.id = new CarritoId(compra.getIdCompra(), producto.getIdProducto());
        this.compra = compra;
        this.producto = producto;
        this.cantidadProducto = cantidadProducto;
        this.subtotal = subtotal;
    }

    // Getters y Setters
    public CarritoId getId() {
        return id;
    }

    public void setId(CarritoId id) {
        this.id = id;
    }

    public Compra getCompra() {
        return compra;
    }

    public void setCompra(Compra compra) {
        this.compra = compra;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public int getCantidadProducto() {
        return cantidadProducto;
    }

    public void setCantidadProducto(int cantidadProducto) {
        this.cantidadProducto = cantidadProducto;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
}
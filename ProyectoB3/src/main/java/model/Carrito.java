
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
    private double subtotal;


    public Carrito() {
    }
    
    public Carrito(int idCompra, int idProducto, int cantidadProducto, double subtotal) {
        this.idCompra = idCompra;
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

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
}

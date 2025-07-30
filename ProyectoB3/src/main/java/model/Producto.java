
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
@Table(name = "Productos")
public class Producto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idProducto")
    private int idProducto;

    @Column(name = "nombreProducto")
    private String nombreProducto;

    @Column(name = "descripcionProducto")
    private String descripcionProducto;
    
    @Column(name = "url_imagen")
    private String url_imagen;

    @Column(name = "tallaProducto")
    private String tallaProducto;

    @Column(name = "marcaProducto")
    private String marcaProducto;
    
    @Column(name = "precioProducto")
    private double precioProducto;
    
    @Column(name = "stockProducto")
    private int stockProducto;
    
    @Column(name = "fechaIngresoProducto")
    private Timestamp fechaIngresoProducto;
    
    @Column(name = "fechaSalidaProducto")
    private Timestamp fechaSalidaProducto;
    
    @Column(name = "idCategoria")
    private int idCategoria;
    
    @Column(name = "idProveedor")
    private int idProveedor;

    public Producto() {
    }

    public Producto(int idProducto, String nombreProducto, String descripcionProducto, String url_imagen, String tallaProducto, String marcaProducto, double precioProducto, int stockProducto, Timestamp fechaIngresoProducto, Timestamp fechaSalidaProducto, int idCategoria, int idProveedor) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.descripcionProducto = descripcionProducto;
        this.url_imagen = url_imagen;
        this.tallaProducto = tallaProducto;
        this.marcaProducto = marcaProducto;
        this.precioProducto = precioProducto;
        this.stockProducto = stockProducto;
        this.fechaIngresoProducto = fechaIngresoProducto;
        this.fechaSalidaProducto = fechaSalidaProducto;
        this.idCategoria = idCategoria;
        this.idProveedor = idProveedor;
    }

    public Producto(String nombreProducto, String descripcionProducto, String url_imagen, String tallaProducto, String marcaProducto, double precioProducto, int stockProducto, Timestamp fechaIngresoProducto, Timestamp fechaSalidaProducto, int idCategoria, int idProveedor) {
        this.nombreProducto = nombreProducto;
        this.descripcionProducto = descripcionProducto;
        this.url_imagen = url_imagen;
        this.tallaProducto = tallaProducto;
        this.marcaProducto = marcaProducto;
        this.precioProducto = precioProducto;
        this.stockProducto = stockProducto;
        this.fechaIngresoProducto = fechaIngresoProducto;
        this.fechaSalidaProducto = fechaSalidaProducto;
        this.idCategoria = idCategoria;
        this.idProveedor = idProveedor;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public String getDescripcionProducto() {
        return descripcionProducto;
    }

    public void setDescripcionProducto(String descripcionProducto) {
        this.descripcionProducto = descripcionProducto;
    }

    public String getTallaProducto() {
        return tallaProducto;
    }

    public void setTallaProducto(String tallaProducto) {
        this.tallaProducto = tallaProducto;
    }

    public String getMarcaProducto() {
        return marcaProducto;
    }

    public void setMarcaProducto(String marcaProducto) {
        this.marcaProducto = marcaProducto;
    }

    public double getPrecioProducto() {
        return precioProducto;
    }

    public void setPrecioProducto(double precioProducto) {
        this.precioProducto = precioProducto;
    }

    public int getStockProducto() {
        return stockProducto;
    }

    public void setStockProducto(int stockProducto) {
        this.stockProducto = stockProducto;
    }

    public Timestamp getFechaIngresoProducto() {
        return fechaIngresoProducto;
    }

    public void setFechaIngresoProducto(Timestamp fechaIngresoProducto) {
        this.fechaIngresoProducto = fechaIngresoProducto;
    }

    public Timestamp getFechaSalidaProducto() {
        return fechaSalidaProducto;
    }

    public void setFechaSalidaProducto(Timestamp fechaSalidaProducto) {
        this.fechaSalidaProducto = fechaSalidaProducto;
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

    public String getUrlImagen() {
        return url_imagen;
    }

    public void setUrlImagen(String url_imagen) {
        this.url_imagen = url_imagen;
    }
}

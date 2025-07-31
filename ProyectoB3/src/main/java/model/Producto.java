package model;

import java.io.Serializable;
import java.sql.Timestamp;
import javax.persistence.*;

@Entity
@Table(name = "Productos")
@NamedQueries({
    @NamedQuery(name = "Producto.findAll", query = "SELECT p FROM Producto p"),
    @NamedQuery(name = "Producto.findByGenero", 
                query = "SELECT p FROM Producto p JOIN p.categoria c WHERE c.nombreCategoriaGenero = :genero"),
    @NamedQuery(name = "Producto.findById", 
                query = "SELECT p FROM Producto p WHERE p.idProducto = :idProducto")
})
public class Producto implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idProducto")
    private int idProducto;

    @Column(name = "nombreProducto", nullable = false, length = 128)
    private String nombreProducto;

    @Column(name = "descripcionProducto", nullable = false, length = 256)
    private String descripcionProducto;

    @Column(name = "url_imagen", nullable = false, length = 255)
    private String urlImagen;

    @Column(name = "tallaProducto", length = 8)
    private String tallaProducto;

    @Column(name = "marcaProducto", nullable = false, length = 64)
    private String marcaProducto;

    @Column(name = "precioProducto", nullable = false)
    private double precioProducto;

    @Column(name = "stockProducto", nullable = false)
    private int stockProducto;

    @Column(name = "fechaIngresoProducto")
    private Timestamp fechaIngresoProducto;

    @Column(name = "fechaSalidaProducto")
    private Timestamp fechaSalidaProducto;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idCategoria", referencedColumnName = "idCategoria", nullable = false)
    private Categoria categoria;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idProveedor", referencedColumnName = "idProveedor", nullable = false)
    private Proveedor proveedor;

    // Constructores
    public Producto() {
    }

    public Producto(String nombreProducto, String descripcionProducto, String urlImagen, 
                   String tallaProducto, String marcaProducto, double precioProducto, 
                   int stockProducto, Categoria categoria, Proveedor proveedor) {
        this.nombreProducto = nombreProducto;
        this.descripcionProducto = descripcionProducto;
        this.urlImagen = urlImagen;
        this.tallaProducto = tallaProducto;
        this.marcaProducto = marcaProducto;
        this.precioProducto = precioProducto;
        this.stockProducto = stockProducto;
        this.categoria = categoria;
        this.proveedor = proveedor;
        this.fechaIngresoProducto = new Timestamp(System.currentTimeMillis());
    }

    // Getters y Setters
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

    public String getUrlImagen() {
        return urlImagen;
    }

    public void setUrlImagen(String urlImagen) {
        this.urlImagen = urlImagen;
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

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public Proveedor getProveedor() {
        return proveedor;
    }

    public void setProveedor(Proveedor proveedor) {
        this.proveedor = proveedor;
    }

    // Métodos auxiliares
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idProducto;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Producto)) {
            return false;
        }
        Producto other = (Producto) object;
        return this.idProducto == other.idProducto;
    }

    @Override
    public String toString() {
        return "model.Producto[ id=" + idProducto + " ]";
    }
}
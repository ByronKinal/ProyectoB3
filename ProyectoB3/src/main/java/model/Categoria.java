package model;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;

@Entity
@Table(name = "Categorias")
public class Categoria implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCategoria")
    private int idCategoria;
    
    @Column(name = "nombreCategoriaTipo", nullable = false, length = 64)
    private String nombreCategoriaTipo;
    
    @Column(name = "nombreCategoriaGenero", nullable = false, length = 64)
    private String nombreCategoriaGenero;
    
    @Column(name = "descripcionCategoria", nullable = false, length = 256)
    private String descripcionCategoria;
    
    @OneToMany(mappedBy = "categoria", fetch = FetchType.LAZY)
    private List<Producto> productos;

    public Categoria() {
    }

    public Categoria(int idCategoria, String nombreCategoriaTipo, String nombreCategoriaGenero, String descripcionCategoria) {
        this.idCategoria = idCategoria;
        this.nombreCategoriaTipo = nombreCategoriaTipo;
        this.nombreCategoriaGenero = nombreCategoriaGenero;
        this.descripcionCategoria = descripcionCategoria;
    }

    public Categoria(String nombreCategoriaTipo, String nombreCategoriaG, String descripcionCategoria) {
        this.nombreCategoriaTipo = nombreCategoriaTipo;
        this.nombreCategoriaGenero = nombreCategoriaG;
        this.descripcionCategoria = descripcionCategoria;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }
    
    public String getDescripcionCategoria() {
        return descripcionCategoria;
    }

    public void setDescripcionCategoria(String descripcionCategoria) {
        this.descripcionCategoria = descripcionCategoria;
    }

    public String getNombreCategoriaTipo() {
        return nombreCategoriaTipo;
    }

    public void setNombreCategoriaTipo(String nombreCategoriaTipo) {
        this.nombreCategoriaTipo = nombreCategoriaTipo;
    }

    public String getNombreCategoriaGenero() {
        return nombreCategoriaGenero;
    }

    public void setNombreCategoriaGenero(String nombreCategoriaG) {
        this.nombreCategoriaGenero = nombreCategoriaG;
    }
}

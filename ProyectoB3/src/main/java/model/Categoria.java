
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
@Table(name = "Categorias")
public class Categoria {
   
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCategoria")
    private int idCategoria;

    @Column(name = "nombreCategoriaTipo")
    private String nombreCategoriaTipo;
    
    @Column(name = "nombreCategoriaG")
    private String nombreCategoriaG;

    @Column(name = "descripcionCategoria")
    private String descripcionCategoria;

    public Categoria() {
    }

    public Categoria(int idCategoria, String nombreCategoriaTipo, String nombreCategoriaG, String descripcionCategoria) {
        this.idCategoria = idCategoria;
        this.nombreCategoriaTipo = nombreCategoriaTipo;
        this.nombreCategoriaG = nombreCategoriaG;
        this.descripcionCategoria = descripcionCategoria;
    }

    public Categoria(String nombreCategoriaTipo, String nombreCategoriaG, String descripcionCategoria) {
        this.nombreCategoriaTipo = nombreCategoriaTipo;
        this.nombreCategoriaG = nombreCategoriaG;
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

    public String getNombreCategoriaG() {
        return nombreCategoriaG;
    }

    public void setNombreCategoriaG(String nombreCategoriaG) {
        this.nombreCategoriaG = nombreCategoriaG;
    }
}

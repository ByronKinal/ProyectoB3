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
@Table(name = "Categorias")
public class Categoria {
   
    


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "idProveedor")
    private int idProveedor;

    @Column(name = "nombreProveedor")
    private int nombreProveedor;

    @Column(name = "correoProveedor")
    private int correoProveedor;

    @Column(name = "telefonoProveedor")
    private int telefonoProveedor;
    
      @Column(name = "direccionProveedor")
    private int direccionProveedor;

    public Categoria() {
    }

    public Categoria(int idProveedor, int nombreProveedor, int correoProveedor, int telefonoProveedor, int direccionProveedor) {
        this.idProveedor = idProveedor;
        this.nombreProveedor = nombreProveedor;
        this.correoProveedor = correoProveedor;
        this.telefonoProveedor = telefonoProveedor;
        this.direccionProveedor = direccionProveedor;
    }

    public Categoria(int nombreProveedor, int correoProveedor, int telefonoProveedor, int direccionProveedor) {
        this.nombreProveedor = nombreProveedor;
        this.correoProveedor = correoProveedor;
        this.telefonoProveedor = telefonoProveedor;
        this.direccionProveedor = direccionProveedor;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public int getNombreProveedor() {
        return nombreProveedor;
    }

    public void setNombreProveedor(int nombreProveedor) {
        this.nombreProveedor = nombreProveedor;
    }

    public int getCorreoProveedor() {
        return correoProveedor;
    }

    public void setCorreoProveedor(int correoProveedor) {
        this.correoProveedor = correoProveedor;
    }

    public int getTelefonoProveedor() {
        return telefonoProveedor;
    }

    public void setTelefonoProveedor(int telefonoProveedor) {
        this.telefonoProveedor = telefonoProveedor;
    }

    public int getDireccionProveedor() {
        return direccionProveedor;
    }

    public void setDireccionProveedor(int direccionProveedor) {
        this.direccionProveedor = direccionProveedor;
    }

   
  



    
    
}

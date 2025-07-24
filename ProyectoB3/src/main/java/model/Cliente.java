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
@Table(name = "Clientes")

public class Cliente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "codigoCliente")
    private int idCliente;

    @Column(name = "correoCliente")
    private int correoCliente;

    @Column(name = "contrasenaCliente")
    private int contrasenaCliente;

    @Column(name = "telefonoCliente")
    private int telefonoCliente;

    public Cliente(int idCliente, int correoCliente, int contrasenaCliente, int telefonoCliente) {
        this.idCliente = idCliente;
        this.correoCliente = correoCliente;
        this.contrasenaCliente = contrasenaCliente;
        this.telefonoCliente = telefonoCliente;
        
        
        
    }

    public Cliente() {
    }

    public Cliente(int correoCliente, int contrasenaCliente, int telefonoCliente) {
        this.correoCliente = correoCliente;
        this.contrasenaCliente = contrasenaCliente;
        this.telefonoCliente = telefonoCliente;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getCorreoCliente() {
        return correoCliente;
    }

    public void setCorreoCliente(int correoCliente) {
        this.correoCliente = correoCliente;
    }

    public int getContrasenaCliente() {
        return contrasenaCliente;
    }

    public void setContrasenaCliente(int contrasenaCliente) {
        this.contrasenaCliente = contrasenaCliente;
    }

    public int getTelefonoCliente() {
        return telefonoCliente;
    }

    public void setTelefonoCliente(int telefonoCliente) {
        this.telefonoCliente = telefonoCliente;
    }

    
    
}

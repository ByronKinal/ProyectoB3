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
    private String correoCliente;

    @Column(name = "contrasenaCliente")
    private String contrasenaCliente;

    @Column(name = "telefonoCliente")
    private int telefonoCliente;

    public Cliente(int idCliente, String correoCliente, String contrasenaCliente, int telefonoCliente) {
        this.idCliente = idCliente;
        this.correoCliente = correoCliente;
        this.contrasenaCliente = contrasenaCliente;
        this.telefonoCliente = telefonoCliente;

    }

    public Cliente() {
    }

    public Cliente(String correoCliente, String contrasenaCliente, int telefonoCliente) {
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

    public String getCorreoCliente() {
        return correoCliente;
    }

    public void setCorreoCliente(String correoCliente) {
        this.correoCliente = correoCliente;
    }

    public String getContrasenaCliente() {
        return contrasenaCliente;
    }

    public void setContrasenaCliente(String contrasenaCliente) {
        this.contrasenaCliente = contrasenaCliente;
    }

    public int getTelefonoCliente() {
        return telefonoCliente;
    }

    public void setTelefonoCliente(int telefonoCliente) {
        this.telefonoCliente = telefonoCliente;
    }

}

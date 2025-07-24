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
@Table(name = "Empleados")
public class Empleado {
    

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "idEmpleado")
    private int idEmpleado;

    @Column(name = "nombreEmpleado")
    private int nombreEmpleado;

    @Column(name = "correoEmpleado")
    private int correoEmpleado;

    @Column(name = "contrasenaEmpleado")
    private int contrasenaEmpleado;

    @Column(name = "idCliente")
    private int idCliente;

    @Column(name = "tipoEmpleado")
    private int tipoEmpleado;

    public Empleado() {
    }

    public Empleado(int idEmpleado, int nombreEmpleado, int correoEmpleado, int contrasenaEmpleado, int idCliente, int tipoEmpleado) {
        this.idEmpleado = idEmpleado;
        this.nombreEmpleado = nombreEmpleado;
        this.correoEmpleado = correoEmpleado;
        this.contrasenaEmpleado = contrasenaEmpleado;
        this.idCliente = idCliente;
        this.tipoEmpleado = tipoEmpleado;
    }

    public Empleado(int nombreEmpleado, int correoEmpleado, int contrasenaEmpleado, int idCliente, int tipoEmpleado) {
        this.nombreEmpleado = nombreEmpleado;
        this.correoEmpleado = correoEmpleado;
        this.contrasenaEmpleado = contrasenaEmpleado;
        this.idCliente = idCliente;
        this.tipoEmpleado = tipoEmpleado;
    }

    public int getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public int getNombreEmpleado() {
        return nombreEmpleado;
    }

    public void setNombreEmpleado(int nombreEmpleado) {
        this.nombreEmpleado = nombreEmpleado;
    }

    public int getCorreoEmpleado() {
        return correoEmpleado;
    }

    public void setCorreoEmpleado(int correoEmpleado) {
        this.correoEmpleado = correoEmpleado;
    }

    public int getContrasenaEmpleado() {
        return contrasenaEmpleado;
    }

    public void setContrasenaEmpleado(int contrasenaEmpleado) {
        this.contrasenaEmpleado = contrasenaEmpleado;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getTipoEmpleado() {
        return tipoEmpleado;
    }

    public void setTipoEmpleado(int tipoEmpleado) {
        this.tipoEmpleado = tipoEmpleado;
    }

   
}

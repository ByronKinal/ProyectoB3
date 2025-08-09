package model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class CarritoId implements Serializable {
    @Column(name = "idCompra")
    private int idCompra;
    
    @Column(name = "idProducto")
    private int idProducto;

    public CarritoId() {
    }

    public CarritoId(int idCompra, int idProducto) {
        this.idCompra = idCompra;
        this.idProducto = idProducto;
    }

    // Getters y Setters
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

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + idCompra;
        result = prime * result + idProducto;
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        CarritoId other = (CarritoId) obj;
        if (idCompra != other.idCompra)
            return false;
        return idProducto == other.idProducto;
    }
}
<<<<<<< HEAD
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.util.List"%>
<%@page import="model.Proveedor"%>
<%@page import="model.Categoria"%>
<%@page import="dao.ProductoDAO"%>
<%@page import="model.Producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Producto</title>
        <link rel="stylesheet" href="StyleRegistroProducto.css">
    </head>
    <body>
        <%
            int idProducto = Integer.parseInt(request.getParameter("id"));
            ProductoDAO productoDAO = new ProductoDAO();
            Producto producto = productoDAO.obtenerProductoCompletoPorId(idProducto);
            
            // Obtener listas de categorías y proveedores
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
            EntityManager em = emf.createEntityManager();
            List<Categoria> categorias = em.createQuery("SELECT c FROM Categoria c", Categoria.class).getResultList();
            List<Proveedor> proveedores = em.createQuery("SELECT p FROM Proveedor p", Proveedor.class).getResultList();
        %>

        <a class="regresar" href="MenuAdministrativo.jsp">Regresar</a>

        <div class="card" >
            <h1>Editar Producto</h1>
            <% if (request.getAttribute("error") != null) {%>
            <div class="error-message"><%= request.getAttribute("error")%></div>
            <% }%>
            <form action="ServletActualizarProducto" method="post">
                <input type="hidden" name="idProducto" value="<%= producto.getIdProducto()%>">

                <div class="form-group">
                    <label class="card-label" for="nombreProducto">Nombre del Producto</label>
                    <input type="text" id="nombreProducto" name="nombreProducto" 
                           value="<%= producto.getNombreProducto()%>" required>
                </div>

                <div class="form-group">
                    <label class="card-label" for="descripcionProducto">Descripción</label>
                    <input type="text" id="descripcionProducto" name="descripcionProducto" 
                           value="<%= producto.getDescripcionProducto()%>" required>
                </div>

                <div class="form-group">
                    <label class="card-label" for="url_imagen">URL de la Imagen</label>
                    <input type="text" id="url_imagen" name="url_imagen" 
                           value="<%= producto.getUrlImagen()%>" required>
                </div>

                <div class="form-group">
                    <label class="card-label" for="tallaProducto">Talla</label>
                    <input type="text" id="tallaProducto" name="tallaProducto" 
                           value="<%= producto.getTallaProducto()%>">
                </div>

                <div class="form-group">
                    <label class="card-label" for="marcaProducto">Marca</label>
                    <input type="text" id="marcaProducto" name="marcaProducto" 
                           value="<%= producto.getMarcaProducto()%>" required>
                </div>

                <div class="form-group">
                    <label class="card-label" for="precioProducto">Precio (Q)</label>
                    <input type="number" step="0.5" id="precioProducto" name="precioProducto" 
                           value="<%= producto.getPrecioProducto()%>" required min="0">
                </div>

                <div class="form-group">
                    <label class="card-label" for="idProveedor">Proveedor</label>
                    <select id="idProveedor" name="idProveedor" required>
                        <% for (Proveedor prov : proveedores) { %>
                        <option value="<%= prov.getIdProveedor()%>" 
                                <%= (producto.getProveedor() != null && producto.getProveedor().getIdProveedor() == prov.getIdProveedor()) ? "selected" : "" %>>
                            <%= prov.getNombreProveedor()%>
                        </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label class="card-label" for="idCategoria">Categoría</label>
                    <select id="idCategoria" name="idCategoria" required>
                        <% for (Categoria cat : categorias) { %>
                        <option value="<%= cat.getIdCategoria()%>" 
                                <%= (producto.getCategoria() != null && producto.getCategoria().getIdCategoria() == cat.getIdCategoria()) ? "selected" : "" %>>
                            <%= cat.getNombreCategoriaGenero()%> - <%= cat.getNombreCategoriaTipo()%>
                        </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label class="card-label" for="stockProducto">Stock</label>
                    <input type="number" step="10" id="stockProducto" name="stockProducto" 
                           value="<%= producto.getStockProducto()%>" required min="0">
                </div>

                <button type="submit">Guardar Cambios</button>
            </form>
        </div>
        <% em.close(); %>
    </body>

</html>
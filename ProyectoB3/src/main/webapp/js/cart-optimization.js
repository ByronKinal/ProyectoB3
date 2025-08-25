/**
 * Client-side Cart Optimization
 * This JavaScript implements AJAX operations for cart management
 * to improve user experience by avoiding full page reloads
 */

// Client-side validation for cart operations
function validarCantidad(cantidad) {
    const num = parseInt(cantidad);
    if (isNaN(num) || num < 1 || num > 10) {
        mostrarMensaje('La cantidad debe ser un número entre 1 y 10', 'error');
        return false;
    }
    return true;
}

// Optimized cart update function with AJAX
function actualizarCarritoAjax(idCompra, idProducto, cantidad) {
    if (!validarCantidad(cantidad)) {
        return;
    }
    
    // Show loading state
    const botonActualizar = event.target;
    const textoOriginal = botonActualizar.textContent;
    botonActualizar.textContent = 'Actualizando...';
    botonActualizar.disabled = true;
    
    const formData = new FormData();
    formData.append('action', 'actualizar');
    formData.append('idCompra', idCompra);
    formData.append('idProducto', idProducto);
    formData.append('cantidad', cantidad);
    
    fetch('ServletCarrito', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (response.redirected) {
            // If redirected, reload the page to show updated cart
            window.location.reload();
        } else {
            return response.text();
        }
    })
    .then(data => {
        if (data) {
            // Update cart display without full page reload
            actualizarVistaCarrito();
            mostrarMensaje('Cantidad actualizada correctamente', 'success');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        mostrarMensaje('Error al actualizar el carrito', 'error');
    })
    .finally(() => {
        // Restore button state
        botonActualizar.textContent = textoOriginal;
        botonActualizar.disabled = false;
    });
}

// Function to update cart view without page reload
function actualizarVistaCarrito() {
    fetch('ServletCarrito')
    .then(response => response.text())
    .then(html => {
        // Parse the response and update only cart content
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');
        const nuevosItems = doc.querySelector('.carrito');
        const nuevoTotal = doc.querySelector('.total');
        
        if (nuevosItems) {
            document.querySelector('.carrito').innerHTML = nuevosItems.innerHTML;
        }
        if (nuevoTotal) {
            document.querySelector('.total').innerHTML = nuevoTotal.innerHTML;
        }
    })
    .catch(error => {
        console.error('Error updating cart view:', error);
    });
}

// Optimized message display function
function mostrarMensaje(mensaje, tipo) {
    // Remove existing messages
    const existingAlerts = document.querySelectorAll('.alert');
    existingAlerts.forEach(alert => alert.remove());
    
    // Create new alert
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${tipo === 'error' ? 'danger' : 'success'} alert-dismissible fade show`;
    alertDiv.innerHTML = `
        ${mensaje}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `;
    
    // Add to alert container
    const container = document.querySelector('.alert-container');
    if (container) {
        container.appendChild(alertDiv);
        
        // Auto-hide after 5 seconds
        setTimeout(() => {
            alertDiv.remove();
        }, 5000);
    }
}

// Add event listeners when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Add client-side validation to quantity inputs
    const cantidadInputs = document.querySelectorAll('input[name="cantidad"]');
    cantidadInputs.forEach(input => {
        input.addEventListener('input', function() {
            const cantidad = this.value;
            const isValid = validarCantidad(cantidad);
            
            // Visual feedback for validation
            if (isValid) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else {
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
            }
        });
    });
    
    // Optimize form submissions with debouncing
    let timeoutId;
    const actualizarButtons = document.querySelectorAll('.btn-actualizar');
    actualizarButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Clear previous timeout
            clearTimeout(timeoutId);
            
            // Debounce the request to prevent multiple rapid submissions
            timeoutId = setTimeout(() => {
                const form = this.closest('form');
                const formData = new FormData(form);
                
                actualizarCarritoAjax(
                    formData.get('idCompra'),
                    formData.get('idProducto'),
                    formData.get('cantidad')
                );
            }, 300);
        });
    });
});

// Preload critical cart operations for better performance
window.addEventListener('load', function() {
    // Preload cart servlet for faster subsequent requests
    const link = document.createElement('link');
    link.rel = 'prefetch';
    link.href = 'ServletCarrito';
    document.head.appendChild(link);
});
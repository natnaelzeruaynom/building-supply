/**
 * Building Supply Management System
 * Core Frontend Logic (Phase 1: LocalStorage)
 */

class InventoryManager {
    constructor() {
        this.items = JSON.parse(localStorage.getItem('building_inventory')) || [];
        this.init();
    }

    init() {
        this.render();
        this.attachEventListeners();
    }

    save() {
        localStorage.setItem('building_inventory', JSON.stringify(this.items));
        this.render();
    }

    addItem(name, quantity, status) {
        const item = {
            id: Date.now(),
            name,
            quantity: parseInt(quantity),
            status,
            date: new Date().toLocaleDateString()
        };
        this.items.push(item);
        this.save();
    }

    deleteItem(id) {
        this.items = this.items.filter(item => item.id !== id);
        this.save();
    }

    render(filter = '') {
        const tbody = document.getElementById('inventory-body');
        const totalItemsEl = document.getElementById('dash-sku-count');
        
        if (!tbody) return;

        tbody.innerHTML = '';
        const filteredItems = this.items.filter(item => 
            item.name.toLowerCase().includes(filter.toLowerCase())
        );

        if (filteredItems.length === 0) {
            tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">No items found.</td></tr>';
        } else {
            filteredItems.forEach((item, index) => {
                const statusClass = item.status === 'In Stock' ? 'success' : 'warning';
                tbody.innerHTML += `
                    <tr>
                        <td class="px-4">${index + 1}</td>
                        <td>
                            <div class="fw-bold text-dark">${item.name}</div>
                            <div class="small text-muted">SKU: BS-${item.id.toString().slice(-6)}</div>
                        </td>
                        <td>${item.quantity}</td>
                        <td><span class="badge bg-${statusClass}">${item.status}</span></td>
                        <td class="text-end px-4">
                            <button class="btn btn-sm btn-light border" onclick="inventory.deleteItem(${item.id})">Remove</button>
                        </td>
                    </tr>
                `;
            });
        }

        if (totalItemsEl) totalItemsEl.innerText = this.items.length;
    }

    attachEventListeners() {
        const form = document.getElementById('add-item-form');
        const searchInput = document.getElementById('inventory-search');

        if (form) {
            form.addEventListener('submit', (e) => {
                e.preventDefault();
                const name = document.getElementById('item-name').value;
                const quantity = document.getElementById('item-quantity').value;
                const status = document.getElementById('item-status').value;
                
                this.addItem(name, quantity, status);
                form.reset();
                
                // Close modal (Bootstrap 5 way)
                const modal = bootstrap.Modal.getInstance(document.getElementById('addItemModal'));
                modal.hide();
            });
        }

        if (searchInput) {
            searchInput.addEventListener('input', (e) => {
                this.render(e.target.value);
            });
        }
    }
}

// Global instance for easy access from HTML
const inventory = new InventoryManager();

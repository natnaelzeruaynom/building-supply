# Building Supply: System Specifications & Architecture 🏗️🔬

This document outlines the roadmap and technical requirements for the **Building Supply Management System**.

## 1. Site Map & Core Screens
-   **Dashboard (Main)**: Overview of inventory health, stock alerts, and summary widgets.
-   **Inventory Module**:
    -   `Inventory List`: Searchable table of all materials.
    -   `Item Details`: Individual item SKU, specs, and price history.
    -   `Stock Adjustment`: Screen for manual audits and corrections.
-   **Procurement & Suppliers**:
    -   `Supplier Directory`: Contact info and performance ratings.
    -   `Purchase Orders`: Track incoming supply shipments.
-   **Sales & Logistics**:
    -   `Material Requests`: Internal/external requests for supplies.
-   **Settings**: RBAC management and system configuration.

---

## 2. Technical Stack (Proposed)

### Client-Side (Frontend)
-   **Framework**: Bootstrap 5 (already initialized).
-   **State Management**: LocalStorage for "No-Backend" phase; React/Vue for Phase 2.
-   **Key Features**: Responsive tables, QR Code generation/scanning hooks, CSV Export.

### Backend-Side (Phase 2)
-   **Language**: Node.js (Express) or Python (FastAPI).
-   **Database**: PostgreSQL (Structured relational data is best for inventory).
-   **Security**: JWT Authentication + Audit Logging.

---

## 3. MoSCoW Feature Prioritization

| Priority | Feature |
| :--- | :--- |
| **Must Have** | CRUD operations for items, Stock level tracking, Search/Filter. |
| **Should Have** | Automated Low Stock alerts, Supplier directory, Purchase Order tracking. |
| **Could Have** | QR/Barcode scanning integration, Price history charts, PDF Export. |
| **Won't Have** | Global multi-warehouse sync (v1), AI-based demand forecasting. |

---

## 4. RBAC (Role-Based Access Control)

| Role | Permissions |
| :--- | :--- |
| **Admin** | Full system control, user management, and financial reports. |
| **Manager** | Manage inventory, suppliers, and approve purchase orders. |
| **Warehouse Staff** | Log incoming/outgoing stock, update stock levels. |
| **Auditor** | Read-only access to inventory and reports. |

---
*Maintained by Tobby jr | Nate.Dev Systems*

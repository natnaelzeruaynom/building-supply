# Building Supply: Backend Architecture & Database Design 🏗️⚙️

This document defines the Phase 2 implementation strategy for the **Building Supply Management System**.

## 1. Tech Stack
- **API**: Node.js (TypeScript) + Express or Fastify.
- **Database**: PostgreSQL (Relational integrity is critical for inventory).
- **Caching**: Redis (For real-time stock counts and session management).
- **Storage**: AWS S3 or Google Cloud Storage (For material spec sheets and invoices).

## 2. Database Schema (Draft)

### `items`
- `id`: UUID (Primary Key)
- `sku`: String (Unique)
- `name`: String
- `category_id`: UUID (FK to categories)
- `unit_of_measure`: Enum (Bag, Pallet, Tonne, Meter)
- `quantity_on_hand`: Decimal
- `reorder_point`: Decimal (Triggers "Low Stock" alert)
- `supplier_id`: UUID (FK to suppliers)
- `created_at`: Timestamp
- `updated_at`: Timestamp

### `suppliers`
- `id`: UUID
- `name`: String
- `contact_email`: String
- `phone`: String
- `reliability_rating`: Integer (1-5)

### `users` & `roles` (RBAC)
- `users`: id, email, password_hash, role_id
- `roles`: id, name (Admin, Manager, Staff, Auditor)
- `permissions`: id, name (inventory_read, inventory_write, po_approve, etc.)

---

## 3. Core API Endpoints

### Inventory
- `GET /api/v1/inventory`: List all items with filters.
- `POST /api/v1/inventory`: Log new supply (Admin/Manager).
- `PATCH /api/v1/inventory/:id/stock`: Update stock levels (Warehouse Staff).

### Procurement
- `POST /api/v1/orders`: Create a purchase order.
- `GET /api/v1/suppliers`: List all verified suppliers.

### Security
- `POST /api/v1/auth/login`: Issue JWT.
- `GET /api/v1/audit-logs`: Trace every change (Admin only).

---
*Architectural Design by Nate.Dev Systems*

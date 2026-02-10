# Building Supply: Database Schema (V1.0) 🏗️🗄️

This SQL schema defines the relational structure for the Building Supply ERP, focusing on multi-unit management and project-site tracking.

```sql
-- Core Inventory Tables
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255),
    phone VARCHAR(50),
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sku VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    category_id UUID REFERENCES categories(id),
    base_unit VARCHAR(50) NOT NULL, -- e.g., 'Bag'
    supplier_id UUID REFERENCES suppliers(id),
    reorder_point DECIMAL(12,2) DEFAULT 10.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Unit Conversion Table (The Construction Logic)
CREATE TABLE unit_conversions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    item_id UUID REFERENCES items(id),
    from_unit VARCHAR(50) NOT NULL,
    to_unit VARCHAR(50) NOT NULL,
    multiplier DECIMAL(12,4) NOT NULL -- e.g., 1 Pallet = 40 Bags
);

-- Warehouse & Jobsite Tracking
CREATE TABLE locations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) CHECK (type IN ('Warehouse', 'Jobsite', 'Transit')),
    address TEXT
);

CREATE TABLE stock_levels (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    item_id UUID REFERENCES items(id),
    location_id UUID REFERENCES locations(id),
    quantity DECIMAL(12,2) DEFAULT 0.00,
    batch_number VARCHAR(100), -- For traceability (Steel Heat #, Dye Lot)
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- RBAC Tables
CREATE TABLE roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) UNIQUE NOT NULL -- Admin, Manager, Staff, Auditor
);

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role_id UUID REFERENCES roles(id),
    last_login TIMESTAMP
);
```

---
*Schema designed by Nate.Dev Systems*

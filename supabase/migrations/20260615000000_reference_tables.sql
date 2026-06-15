-- IPPOO Market - Reference Tables Migration

-- 1. African Countries
CREATE TABLE IF NOT EXISTS african_countries (
    iso CHAR(2) PRIMARY KEY,
    name TEXT NOT NULL,
    dial TEXT NOT NULL,
    nsn_min INTEGER NOT NULL,
    nsn_max INTEGER NOT NULL,
    example TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Catalog Categories (Mega-categories)
CREATE TABLE IF NOT EXISTS catalog_categories (
    id TEXT PRIMARY KEY,
    code TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    icon TEXT,
    color TEXT,
    image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Catalog Items (Taxonomy/Sub-categories)
CREATE TABLE IF NOT EXISTS catalog_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    parent_id UUID REFERENCES catalog_items(id),
    category_id TEXT REFERENCES catalog_categories(id),
    name TEXT NOT NULL,
    image_url TEXT,
    level INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Sectors (Primary, Secondary, Tertiary)
CREATE TABLE IF NOT EXISTS sectors (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL,
    icon TEXT,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. Subsectors
CREATE TABLE IF NOT EXISTS subsectors (
    id TEXT PRIMARY KEY,
    sector_id TEXT REFERENCES sectors(id),
    label TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. Niches (Jobs/Professions)
CREATE TABLE IF NOT EXISTS niches (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subsector_id TEXT REFERENCES subsectors(id),
    label TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. Business Circuits
CREATE TABLE IF NOT EXISTS circuits (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL,
    description TEXT,
    icon TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. Juridical Forms
CREATE TABLE IF NOT EXISTS juridical_forms (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 9. Product Units
CREATE TABLE IF NOT EXISTS product_units (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 10. Origins, Colors, Sizes, Brands (Optional reference tables or Enums)
CREATE TABLE IF NOT EXISTS product_origins (
    name TEXT PRIMARY KEY,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS product_colors (
    name TEXT PRIMARY KEY,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS product_sizes (
    name TEXT PRIMARY KEY,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS product_brands (
    name TEXT PRIMARY KEY,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 11. Vendors
CREATE TABLE IF NOT EXISTS vendors (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT,
    rating DECIMAL(3,2) DEFAULT 0,
    verified BOOLEAN DEFAULT FALSE,
    joined_year TEXT,
    owner_id UUID REFERENCES auth.users(id),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 12. Shops
CREATE TABLE IF NOT EXISTS shops (
    id TEXT PRIMARY KEY,
    vendor_id TEXT REFERENCES vendors(id),
    name TEXT NOT NULL,
    niche_id TEXT REFERENCES catalog_categories(id),
    niche_name TEXT,
    city TEXT,
    rating DECIMAL(3,2) DEFAULT 0,
    verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 13. Products
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    shop_id TEXT REFERENCES shops(id),
    vendor_id TEXT REFERENCES vendors(id),
    catalog_id TEXT REFERENCES catalog_categories(id),
    name TEXT NOT NULL,
    image_url TEXT,
    price INTEGER NOT NULL,
    moq INTEGER NOT NULL DEFAULT 1,
    unit TEXT REFERENCES product_units(id),
    rating DECIMAL(3,2) DEFAULT 0,
    category_label TEXT,
    in_stock BOOLEAN DEFAULT TRUE,
    stock_qty INTEGER DEFAULT 0,
    subcategory TEXT,
    subcategory_path TEXT,
    origin TEXT REFERENCES product_origins(name),
    color TEXT REFERENCES product_colors(name),
    size TEXT REFERENCES product_sizes(name),
    weight_kg DECIMAL(10,2),
    brand TEXT REFERENCES product_brands(name),
    reference TEXT UNIQUE,
    paliers JSONB, -- Array of {qty, price}
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS on all tables
ALTER TABLE african_countries ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendors ENABLE ROW LEVEL SECURITY;
ALTER TABLE shops ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE catalog_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE catalog_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE sectors ENABLE ROW LEVEL SECURITY;
ALTER TABLE subsectors ENABLE ROW LEVEL SECURITY;
ALTER TABLE niches ENABLE ROW LEVEL SECURITY;
ALTER TABLE circuits ENABLE ROW LEVEL SECURITY;
ALTER TABLE juridical_forms ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_units ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_origins ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_colors ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_sizes ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_brands ENABLE ROW LEVEL SECURITY;

-- Read-only policies for public
CREATE POLICY "Public read access for african_countries" ON african_countries FOR SELECT USING (true);
CREATE POLICY "Public read access for catalog_categories" ON catalog_categories FOR SELECT USING (true);
CREATE POLICY "Public read access for catalog_items" ON catalog_items FOR SELECT USING (true);
CREATE POLICY "Public read access for sectors" ON sectors FOR SELECT USING (true);
CREATE POLICY "Public read access for subsectors" ON subsectors FOR SELECT USING (true);
CREATE POLICY "Public read access for niches" ON niches FOR SELECT USING (true);
CREATE POLICY "Public read access for circuits" ON circuits FOR SELECT USING (true);
CREATE POLICY "Public read access for juridical_forms" ON juridical_forms FOR SELECT USING (true);
CREATE POLICY "Public read access for product_units" ON product_units FOR SELECT USING (true);
CREATE POLICY "Public read access for product_origins" ON product_origins FOR SELECT USING (true);
CREATE POLICY "Public read access for product_colors" ON product_colors FOR SELECT USING (true);
CREATE POLICY "Public read access for product_sizes" ON product_sizes FOR SELECT USING (true);
CREATE POLICY "Public read access for product_brands" ON product_brands FOR SELECT USING (true);
CREATE POLICY "Public read access for vendors" ON vendors FOR SELECT USING (true);
CREATE POLICY "Public read access for shops" ON shops FOR SELECT USING (true);
CREATE POLICY "Public read access for products" ON products FOR SELECT USING (true);

-- Authenticated users can manage their own vendor profile
CREATE POLICY "Vendors can update their own profile" ON vendors
    FOR UPDATE USING (auth.uid() = owner_id);

-- 14. Blog Articles
CREATE TABLE IF NOT EXISTS blog_articles (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    excerpt TEXT,
    category TEXT,
    read_time TEXT,
    published_date DATE,
    image_url TEXT,
    color TEXT,
    featured BOOLEAN DEFAULT FALSE,
    views INTEGER DEFAULT 0,
    content JSONB, -- Array of {type, text, title, src, caption}
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE blog_articles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read access for blog_articles" ON blog_articles FOR SELECT USING (true);

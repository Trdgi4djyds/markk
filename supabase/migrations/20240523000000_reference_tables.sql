-- Migration: Reference Tables for IPPOO Market
-- Description: Creates and populates reference tables for countries, categories, sectors, and more.
-- All tables are prefixed with 'ippoo_market_' as requested.

-- 1. Countries
CREATE TABLE IF NOT EXISTS ippoo_market_ref_countries (
    iso CHAR(2) PRIMARY KEY,
    name TEXT NOT NULL,
    dial TEXT NOT NULL,
    nsn_min INTEGER NOT NULL,
    nsn_max INTEGER NOT NULL,
    example TEXT
);

-- 2. Categories (Hierarchical)
CREATE TABLE IF NOT EXISTS ippoo_market_ref_categories (
    id TEXT PRIMARY KEY,
    parent_id TEXT REFERENCES ippoo_market_ref_categories(id),
    code TEXT,
    icon TEXT,
    name TEXT NOT NULL,
    color TEXT,
    image TEXT
);

-- 3. Sectors, Subsectors and Niches
CREATE TABLE IF NOT EXISTS ippoo_market_ref_sectors (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL,
    icon TEXT,
    description TEXT
);

CREATE TABLE IF NOT EXISTS ippoo_market_ref_subsectors (
    id TEXT PRIMARY KEY,
    sector_id TEXT NOT NULL REFERENCES ippoo_market_ref_sectors(id),
    label TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS ippoo_market_ref_niches (
    id SERIAL PRIMARY KEY,
    sector_id TEXT NOT NULL REFERENCES ippoo_market_ref_sectors(id),
    subsector_id TEXT NOT NULL REFERENCES ippoo_market_ref_subsectors(id),
    label TEXT NOT NULL
);

-- 4. Business Circuits
CREATE TABLE IF NOT EXISTS ippoo_market_ref_circuits (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL,
    description TEXT,
    icon TEXT
);

-- 5. Juridical Forms
CREATE TABLE IF NOT EXISTS ippoo_market_ref_juridical_forms (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL
);

-- SEEDING DATA

-- Countries
INSERT INTO ippoo_market_ref_countries (iso, name, dial, nsn_min, nsn_max, example) VALUES
('DZ', 'Algérie', '213', 9, 9, '+213 5 51 23 45 67'),
('AO', 'Angola', '244', 9, 9, '+244 923 123 456'),
('BJ', 'Bénin', '229', 10, 12, '+229 01 91 00 00 00 00'),
('BW', 'Botswana', '267', 7, 8, '+267 71 234 567'),
('BF', 'Burkina Faso', '226', 8, 8, '+226 70 12 34 56'),
('BI', 'Burundi', '257', 8, 8, '+257 79 56 12 34'),
('CV', 'Cap-Vert', '238', 7, 7, '+238 991 12 34'),
('CM', 'Cameroun', '237', 9, 9, '+237 6 71 23 45 67'),
('CF', 'Centrafrique', '236', 8, 8, '+236 70 12 34 56'),
('TD', 'Tchad', '235', 8, 8, '+235 63 01 23 45'),
('KM', 'Comores', '269', 7, 7, '+269 321 23 45'),
('CG', 'Congo', '242', 9, 9, '+242 06 123 45 67'),
('CD', 'RD Congo', '243', 9, 9, '+243 991 234 567'),
('CI', 'Côte d''Ivoire', '225', 10, 10, '+225 01 23 45 67 89'),
('DJ', 'Djibouti', '253', 8, 8, '+253 77 83 10 01'),
('EG', 'Égypte', '20', 9, 10, '+20 100 123 4567'),
('GQ', 'Guinée équatoriale', '240', 9, 9, '+240 222 123 456'),
('ER', 'Érythrée', '291', 7, 7, '+291 7 123 456'),
('SZ', 'Eswatini', '268', 8, 8, '+268 7612 3456'),
('ET', 'Éthiopie', '251', 9, 9, '+251 91 123 4567'),
('GA', 'Gabon', '241', 8, 9, '+241 06 03 12 34'),
('GM', 'Gambie', '220', 7, 7, '+220 301 23 45'),
('GH', 'Ghana', '233', 9, 9, '+233 23 123 4567'),
('GN', 'Guinée', '224', 8, 9, '+224 601 12 34 56'),
('GW', 'Guinée-Bissau', '245', 7, 9, '+245 955 123 456'),
('KE', 'Kenya', '254', 9, 9, '+254 712 123 456'),
('LS', 'Lesotho', '266', 8, 8, '+266 5012 3456'),
('LR', 'Libéria', '231', 7, 9, '+231 770 123 456'),
('LY', 'Libye', '218', 9, 10, '+218 91 234 5678'),
('MG', 'Madagascar', '261', 9, 9, '+261 32 12 345 67'),
('MW', 'Malawi', '265', 9, 9, '+265 991 23 45 67'),
('ML', 'Mali', '223', 8, 8, '+223 65 01 23 45'),
('MR', 'Mauritanie', '222', 8, 8, '+222 22 12 34 56'),
('MU', 'Maurice', '230', 7, 8, '+230 5251 2345'),
('MA', 'Maroc', '212', 9, 9, '+212 6 12 34 56 78'),
('MZ', 'Mozambique', '258', 9, 9, '+258 82 123 4567'),
('NA', 'Namibie', '264', 7, 10, '+264 81 123 4567'),
('NE', 'Niger', '227', 8, 8, '+227 90 12 34 56'),
('NG', 'Nigéria', '234', 10, 10, '+234 802 123 4567'),
('RW', 'Rwanda', '250', 9, 9, '+250 720 123 456'),
('ST', 'Sao Tomé-et-Principe', '239', 7, 7, '+239 981 23 45'),
('SN', 'Sénégal', '221', 9, 9, '+221 70 123 45 67'),
('SC', 'Seychelles', '248', 7, 7, '+248 2 510 123'),
('SL', 'Sierra Leone', '232', 8, 8, '+232 25 123 456'),
('SO', 'Somalie', '252', 7, 9, '+252 61 234 5678'),
('ZA', 'Afrique du Sud', '27', 9, 9, '+27 71 123 4567'),
('SS', 'Soudan du Sud', '211', 9, 9, '+211 97 123 4567'),
('SD', 'Soudan', '249', 9, 9, '+249 91 123 4567'),
('TZ', 'Tanzanie', '255', 9, 9, '+255 621 234 567'),
('TG', 'Togo', '228', 8, 8, '+228 90 11 23 45'),
('TN', 'Tunisie', '216', 8, 8, '+216 20 123 456'),
('UG', 'Ouganda', '256', 9, 9, '+256 712 345 678'),
('EH', 'Sahara occidental', '212', 9, 9, '+212 6 12 34 56 78'),
('ZM', 'Zambie', '260', 9, 9, '+260 95 1234567'),
('ZW', 'Zimbabwe', '263', 9, 10, '+263 71 234 5678')
ON CONFLICT (iso) DO NOTHING;

-- Sectors
INSERT INTO ippoo_market_ref_sectors (id, label, icon, description) VALUES
('primaire', 'Secteur Primaire', '🌾', 'Agriculture, élevage, pêche, exploitation des ressources naturelles'),
('secondaire', 'Secteur Secondaire', '🏭', 'Transformation, artisanat, fabrication, industrie'),
('tertiaire', 'Secteur Tertiaire', '🛒', 'Commerce, distribution, logistique et services')
ON CONFLICT (id) DO NOTHING;

-- Subsectors
INSERT INTO ippoo_market_ref_subsectors (id, sector_id, label) VALUES
('cultures-vivrieres', 'primaire', 'Cultures vivrières'),
('maraichage', 'primaire', 'Maraîchage'),
('fruits', 'primaire', 'Fruits'),
('cultures-industrielles', 'primaire', 'Cultures industrielles'),
('elevage-traditionnel', 'primaire', 'Élevage traditionnel'),
('aviculture', 'primaire', 'Aviculture'),
('autres-elevages', 'primaire', 'Autres élevages'),
('peche', 'primaire', 'Pêche'),
('ressources-naturelles', 'primaire', 'Ressources naturelles'),
('transfo-manioc', 'secondaire', 'Produits du manioc'),
('transfo-cereales', 'secondaire', 'Produits céréaliers'),
('huiles', 'secondaire', 'Huiles'),
('produits-animaux', 'secondaire', 'Produits animaux'),
('produits-laitiers', 'secondaire', 'Produits laitiers'),
('produits-sucres', 'secondaire', 'Produits sucrés & boissons'),
('boulangerie', 'secondaire', 'Boulangerie / Pâtisserie'),
('metal', 'secondaire', 'Métal & Mécanique'),
('bois', 'secondaire', 'Bois & Menuiserie'),
('textile', 'secondaire', 'Textile & Mode'),
('cuir', 'secondaire', 'Cuir & Accessoires'),
('cosmetique', 'secondaire', 'Cosmétique & Hygiène'),
('materiaux', 'secondaire', 'Matériaux de construction'),
('artisanat', 'secondaire', 'Artisanat divers'),
('grossiste-alim', 'tertiaire', 'Distribution alimentaire'),
('grossiste-non-alim', 'tertiaire', 'Distribution non alimentaire'),
('commerce-alim', 'tertiaire', 'Commerce alimentaire (détail)'),
('commerce-non-alim', 'tertiaire', 'Commerce non alimentaire (détail)'),
('transport', 'tertiaire', 'Transport & Logistique'),
('services-perso', 'tertiaire', 'Services personnels'),
('reparation', 'tertiaire', 'Réparation & Maintenance'),
('restauration', 'tertiaire', 'Restauration & Boissons'),
('services-divers', 'tertiaire', 'Services divers')
ON CONFLICT (id) DO NOTHING;

-- Circuits
INSERT INTO ippoo_market_ref_circuits (id, label, description, icon) VALUES
('producteur', 'Producteur', 'Agriculture, élevage, pêche, coopératives', '🌿'),
('transformateur', 'Transformateur', 'Agro-transformation, artisanat, industrie', '🏭'),
('distributeur', 'Distributeur', 'Grossiste, semi-grossiste, importateur', '🚚'),
('revendeur', 'Revendeur / Commerçant', 'Boutique, supermarché, e-commerce', '🛒')
ON CONFLICT (id) DO NOTHING;

-- Juridical Forms
INSERT INTO ippoo_market_ref_juridical_forms (id, label) VALUES
('individuelle', 'Entreprise individuelle (personne physique)'),
('ei', 'EI / Auto-entrepreneur'),
('sarl', 'SARL'),
('sa', 'SA'),
('cooperative', 'Coopérative'),
('association', 'Association'),
('gie', 'GIE (Groupement d''Intérêt Économique)'),
('autre', 'Autre')
ON CONFLICT (id) DO NOTHING;

INSERT INTO ippoo_market_ref_categories (id, parent_id, code, icon, name, color, image) VALUES
('telephonie', NULL, '1', 'Smartphone', 'Téléphonie & Objets connectés', '#3B82F6', 'https://images.unsplash.com/photo-1719945421298-f03d3d80c3e1?auto=format&fit=crop&w=800&q=70'),
('informatique', NULL, '2', 'Laptop', 'Informatique & High-Tech', '#6366F1', 'https://images.unsplash.com/photo-1511385348-a52b4a160dc2?auto=format&fit=crop&w=800&q=70'),
('electronique', NULL, '3', 'Tv', 'Électronique & Multimédia', '#0EA5E9', 'https://images.unsplash.com/photo-1651340675491-6fb0bfb5c4ea?auto=format&fit=crop&w=800&q=70'),
('electromenager', NULL, '4', 'Refrigerator', 'Électroménager & Maison', '#9333EA', 'https://images.unsplash.com/photo-1721613877687-c9099b698faa?auto=format&fit=crop&w=800&q=70'),
('mode-femme', NULL, '5', 'Shirt', 'Mode Femme', '#EC4899', 'https://images.unsplash.com/photo-1532453288672-3a27e9be9efd?auto=format&fit=crop&w=800&q=70'),
('mode-homme', NULL, '6', 'Shirt', 'Mode Homme', '#1E40AF', 'https://images.unsplash.com/photo-1618886614638-80e3c103d31a?auto=format&fit=crop&w=800&q=70'),
('enfants-bebe', NULL, '7', 'Baby', 'Enfants & Bébé', '#FBBF24', 'https://images.unsplash.com/photo-1498940757830-82f7813bf178?auto=format&fit=crop&w=800&q=70'),
('beaute', NULL, '8', 'Sparkles', 'Beauté & Cosmétique', '#F0278E', 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?auto=format&fit=crop&w=800&q=70'),
('sante', NULL, '9', 'HeartPulse', 'Santé & Hygiène', '#10B981', 'https://images.unsplash.com/photo-1576602976047-174e57a47881?auto=format&fit=crop&w=800&q=70'),
('maison-deco', NULL, '10', 'Sofa', 'Maison & Décoration', '#16A34A', 'https://images.unsplash.com/photo-1558442074-3c19857bc1dc?auto=format&fit=crop&w=800&q=70'),
('alimentation', NULL, '11', 'UtensilsCrossed', 'Alimentation & Supermarché', '#FF6B00', 'https://images.unsplash.com/photo-1630960411440-10f7b59717ba?auto=format&fit=crop&w=800&q=70'),
('sport', NULL, '12', 'Dumbbell', 'Sport & Loisirs', '#F97316', 'https://images.unsplash.com/photo-1591311630200-ffa9120a540f?auto=format&fit=crop&w=800&q=70'),
('gaming', NULL, '13', 'Gamepad2', 'Gaming & Loisirs numériques', '#8B5CF6', 'https://images.unsplash.com/photo-1493711662062-fa541adb3fc8?auto=format&fit=crop&w=800&q=70'),
('auto-moto', NULL, '14', 'Car', 'Auto & Moto', '#DC2626', 'https://images.unsplash.com/photo-1625811485537-af2c05a0232d?auto=format&fit=crop&w=800&q=70'),
('bricolage', NULL, '15', 'Wrench', 'Bricolage & Construction', '#78716C', 'https://images.unsplash.com/photo-1426927308491-6380b6a9936f?auto=format&fit=crop&w=800&q=70'),
('librairie', NULL, '16', 'BookOpen', 'Librairie & Papeterie', '#6366F1', 'https://images.unsplash.com/photo-1532012197267-da84d127e765?auto=format&fit=crop&w=800&q=70'),
('musique', NULL, '17', 'Music', 'Musique & Instruments', '#A855F7', 'https://images.unsplash.com/photo-1510915361894-db8b60106cb1?auto=format&fit=crop&w=800&q=70'),
('voyage', NULL, '18', 'Luggage', 'Voyage & Bagagerie', '#0D9488', 'https://images.unsplash.com/photo-1639598003276-8a70fcaaad6c?auto=format&fit=crop&w=800&q=70'),
('services', NULL, '19', 'Briefcase', 'Services (Marketplace hybride)', '#0EA5E9', 'https://images.unsplash.com/photo-1549923746-c502d488b3ea?auto=format&fit=crop&w=800&q=70'),
('artisanat', NULL, '20', 'Palette', 'Produits locaux & artisanat', '#E8A817', 'https://images.unsplash.com/photo-1534413340928-7bd74b65196f?auto=format&fit=crop&w=800&q=70')
ON CONFLICT (id) DO NOTHING;

INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de maïs');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de riz');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de sorgho');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de mil');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de niébé');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de soja');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur d''arachide');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur de manioc');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur d''igname');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur de patate douce');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur de taro');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur de banane plantain');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Jardinier vivrier');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur de légumes locaux');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de tomate');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de piment');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de poivron');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur d''oignon');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur d''ail');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de laitue');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de concombre');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de choux');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de carotte');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur d''aubergine africaine');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de feuilles (gboma, amarante, basilic, menthe)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''ananas');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''mangue');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''orange');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''citron');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''goyave');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''papaye');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''pastèque');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''banane douce');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''noix de coco');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de coton');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de noix de cajou');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de palmier à huile');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de cacao');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de café');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de tabac');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de soja industriel');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur bovin');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur ovin');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur caprin');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur porcin');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur de chevaux');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur d''ânes');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur poulets de chair');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur pondeuses');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur pintades');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur cailles');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur canards');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur dindons');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Producteur d''œufs');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'autres-elevages', 'Apiculteur');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'autres-elevages', 'Héliciculteur (escargots)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'autres-elevages', 'Cuniculture (lapins)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'autres-elevages', 'Éleveur de poissons (aquaculture)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Pêcheur artisanal');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Pêcheur lagunaire');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Pêcheur de rivière');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Pêcheur maritime (barques)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Poseur de nasses');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Fabricant de filets');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Mareyeur');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Fumeur de poisson');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Sécheur de poisson');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Vendeur de poisson frais');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Vendeur de crustacés');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Producteur d''écrevisses');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Charbonnier (fabrication charbon de bois)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Collecteur de bois de chauffe');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Exploitant de sable');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Exploitant de latérite');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Exploitant de gravier');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Cueilleur de plantes médicinales');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Collecteur de feuilles (palme, rônier)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Exploitant de fibres naturelles (raphia, bambou)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Producteur d''argile');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-manioc', 'Transformateur de gari');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-manioc', 'Transformateur de tapioca');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-manioc', 'Transformateur de cossettes');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-manioc', 'Producteur d''attiéké');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-manioc', 'Vente de pâte de manioc');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-cereales', 'Meunier');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-cereales', 'Transformateur de farine de maïs');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-cereales', 'Transformateur de farine de riz');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-cereales', 'Fabricant de akassa / pâte');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-cereales', 'Fabricant de bouillies locales');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'huiles', 'Producteur d''huile rouge');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'huiles', 'Producteur d''huile palmiste');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'huiles', 'Producteur d''huile d''arachide');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'huiles', 'Producteur d''huile de soja');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-animaux', 'Boucherie artisanale');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-animaux', 'Abattage informel');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-animaux', 'Charcutier traditionnel');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-laitiers', 'Producteur de fromage peulh');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-laitiers', 'Producteur de yaourt artisanal');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-laitiers', 'Producteur de lait caillé');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-sucres', 'Fabricant de jus locaux (gingembre, bissap, zobo)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-sucres', 'Fabricant de sirops');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-sucres', 'Fabricant de confitures');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'boulangerie', 'Boulanger traditionnel');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'boulangerie', 'Fabricant de beignets');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'boulangerie', 'Fabricant de gâteaux locaux');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'boulangerie', 'Fabricant de galettes');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Soudeur');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Métallier');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Forgeron');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Fabricant de portails');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Fabricant d''outils agricoles');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Réparateur auto');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Réparateur moto');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Réparateur de vélos');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Bobineur');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Tôlier');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Menuisier bois');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Charpentier');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Fabricant de meubles');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Fabricant de lits');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Fabricant de tables');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Fabricant de portes');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Couturier');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Styliste');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Brodeur');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Tisserand');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Fabricant de pagnes tissés');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Fabricant de sacs artisanaux');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Fabricant de sandales en pagne');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Teinturière / batik');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cuir', 'Cordonnier');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cuir', 'Fabricant de chaussures');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cuir', 'Fabricant de ceintures');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cuir', 'Fabricant de sacs en cuir');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cosmetique', 'Savonnier (savon noir, savon de toilette)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cosmetique', 'Fabricant d''huiles naturelles (coco, karité, neem)');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cosmetique', 'Fabricant de pommades naturelles');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cosmetique', 'Fabricant de parfums artisanaux');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'materiaux', 'Fabricant de briques en terre');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'materiaux', 'Fabricant de briques ciment');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'materiaux', 'Fabricant de carreaux artisanaux');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'materiaux', 'Fabricant de peintures locales');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Sculpteur');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Peintre sur toile');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Fabricant de bijoux');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Fabricant d''objets décoratifs');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Fabricant d''ustensiles traditionnels');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Fabricant de balais');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Fabricant de paniers');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste céréales');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Semi-grossiste céréales');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste tubercules');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste volailles');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste poissons');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Dépôt d''œufs');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Dépôt de boissons');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Dépôt d''eau minérale');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste jus');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste fruits et légumes');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste produits cosmétiques');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste produits ménagers');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste chaussures');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste vêtements');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste sacs');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste pièces détachées moto');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste pièces détachées auto');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste matériaux de construction');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur vivriers');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur légumes frais');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur poissons frais');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur poissons fumés');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur viandes');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur volailles');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur épices');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur huiles alimentaires');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur pains');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur boissons');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Marchande de beignets');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Marchande de bouillies');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Marchande de fruits');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de vêtements');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de friperie');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur d''articles pour bébés');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de sacs');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de téléphones');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de coques & accessoires');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur d''appareils électroménagers');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur d''ustensiles de cuisine');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de meubles d''occasion');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de tapis');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de chaussures');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'transport', 'Conducteur de taxi-moto');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'transport', 'Conducteur taxi tricycle');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'transport', 'Conducteur taxi-bus');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'transport', 'Transporteur de marchandises');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'transport', 'Transporteur à tricycle cargo');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Coiffeuse');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Coiffeur');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Tresseuse');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Esthéticienne');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Maquilleuse');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Barbier');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Lavandière');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur téléphone');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur ordinateurs');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur électroménagers');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur télévision');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur ventilateurs');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur groupes électrogènes');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur panneaux solaires');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Restauratrice de rue');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Vendeur de grillades');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Vendeur de brochettes');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Vendeur de sandwichs');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Vendeur de café / thé');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Gérant de maquis');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Gérant de bar local');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Photographe');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Vidéaste');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Imprimeur de rue');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Agent de nettoyage');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Agent de gardiennage');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Laveur de vitres');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Laveur de motos');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Laveur de voitures');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Dépanneur rapide');
INSERT INTO ippoo_market_ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Changeur de monnaie');

INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-smartphones-android', 'telephonie', 'Smartphones Android');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-smartphones-ios', 'telephonie', 'Smartphones iOS');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-t-l-phones-basiques', 'telephonie', 'Téléphones basiques');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-t-l-phones-professionnels', 'telephonie', 'Téléphones professionnels');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-tablettes', 'telephonie', 'Tablettes');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-ipad-tablettes-premium', 'telephonie', 'iPad & tablettes premium');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-coques-protections', 'telephonie', 'Coques & protections');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-verres-tremp-s', 'telephonie', 'Verres trempés');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-chargeurs-adaptateurs', 'telephonie', 'Chargeurs & adaptateurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-c-bles-usb-type-c-lightning', 'telephonie', 'Câbles USB / Type-C / Lightning');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-powerbanks', 'telephonie', 'Powerbanks');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-couteurs-casques', 'telephonie', 'Écouteurs & casques');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-montres-connect-es', 'telephonie', 'Montres connectées');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-bracelets-connect-s', 'telephonie', 'Bracelets connectés');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-accessoires-bluetooth', 'telephonie', 'Accessoires Bluetooth');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('telephonie-cartes-m-moire-stockage', 'telephonie', 'Cartes mémoire & stockage');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-ordinateurs-portables', 'informatique', 'Ordinateurs portables');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-pc-de-bureau', 'informatique', 'PC de bureau');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-macbook-imac', 'informatique', 'MacBook & iMac');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-crans-moniteurs', 'informatique', 'Écrans & moniteurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-imprimantes', 'informatique', 'Imprimantes');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-scanner', 'informatique', 'Scanner');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-claviers', 'informatique', 'Claviers');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-souris', 'informatique', 'Souris');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-tapis-de-souris', 'informatique', 'Tapis de souris');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-disques-durs-ssd', 'informatique', 'Disques durs / SSD');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-ram', 'informatique', 'RAM');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-cartes-graphiques', 'informatique', 'Cartes graphiques');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-processeurs', 'informatique', 'Processeurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-cartes-m-res', 'informatique', 'Cartes mères');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-onduleurs', 'informatique', 'Onduleurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-routeurs-modems', 'informatique', 'Routeurs & modems');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-r-p-teurs-wifi', 'informatique', 'Répéteurs WiFi');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-serveurs-nas', 'informatique', 'Serveurs & NAS');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('informatique-accessoires-pc', 'informatique', 'Accessoires PC');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-t-l-visions-led-smart-tv', 'electronique', 'Télévisions LED / Smart TV');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-projecteurs', 'electronique', 'Projecteurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-home-cin-ma', 'electronique', 'Home cinéma');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-barres-de-son', 'electronique', 'Barres de son');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-amplificateurs', 'electronique', 'Amplificateurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-radios', 'electronique', 'Radios');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-cam-ras-vid-o', 'electronique', 'Caméras vidéo');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-appareils-photo', 'electronique', 'Appareils photo');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-drones', 'electronique', 'Drones');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-cam-ras-de-surveillance', 'electronique', 'Caméras de surveillance');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-alarmes-connect-es', 'electronique', 'Alarmes connectées');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electronique-accessoires-photo-vid-o', 'electronique', 'Accessoires photo/vidéo');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-r-frig-rateurs', 'electromenager', 'Réfrigérateurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-cong-lateurs', 'electromenager', 'Congélateurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-cuisini-res', 'electromenager', 'Cuisinières');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-fours-micro-ondes', 'electromenager', 'Fours & micro-ondes');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-blenders-mixeurs', 'electromenager', 'Blenders & mixeurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-machines-caf', 'electromenager', 'Machines à café');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-bouilloires', 'electromenager', 'Bouilloires');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-fers-repasser', 'electromenager', 'Fers à repasser');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-machines-laver', 'electromenager', 'Machines à laver');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-aspirateurs', 'electromenager', 'Aspirateurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-ventilateurs', 'electromenager', 'Ventilateurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-climatiseurs', 'electromenager', 'Climatiseurs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-chauffe-eau', 'electromenager', 'Chauffe-eau');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('electromenager-appareils-de-cuisine', 'electromenager', 'Appareils de cuisine');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-robes', 'mode-femme', 'Robes');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-jupes', 'mode-femme', 'Jupes');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-pantalons', 'mode-femme', 'Pantalons');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-tops-chemises', 'mode-femme', 'Tops & chemises');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-t-shirts', 'mode-femme', 'T-shirts');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-tenues-traditionnelles', 'mode-femme', 'Tenues traditionnelles');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-lingerie', 'mode-femme', 'Lingerie');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-maillots-de-bain', 'mode-femme', 'Maillots de bain');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-chaussures', 'mode-femme', 'Chaussures');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-sandales', 'mode-femme', 'Sandales');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-talons', 'mode-femme', 'Talons');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-sacs-main', 'mode-femme', 'Sacs à main');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-bijoux', 'mode-femme', 'Bijoux');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-femme-accessoires', 'mode-femme', 'Accessoires');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-chemises', 'mode-homme', 'Chemises');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-t-shirts', 'mode-homme', 'T-shirts');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-pantalons', 'mode-homme', 'Pantalons');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-jeans', 'mode-homme', 'Jeans');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-costumes', 'mode-homme', 'Costumes');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-tenues-traditionnelles', 'mode-homme', 'Tenues traditionnelles');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-sous-v-tements', 'mode-homme', 'Sous-vêtements');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-chaussures', 'mode-homme', 'Chaussures');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-sneakers', 'mode-homme', 'Sneakers');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-sandales', 'mode-homme', 'Sandales');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-montres', 'mode-homme', 'Montres');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-ceintures', 'mode-homme', 'Ceintures');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('mode-homme-sacs', 'mode-homme', 'Sacs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-v-tements-b-b', 'enfants-bebe', 'Vêtements bébé');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-v-tements-enfants', 'enfants-bebe', 'Vêtements enfants');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-chaussures-enfants', 'enfants-bebe', 'Chaussures enfants');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-jouets-ducatifs', 'enfants-bebe', 'Jouets éducatifs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-jouets-lectroniques', 'enfants-bebe', 'Jouets électroniques');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-peluches', 'enfants-bebe', 'Peluches');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-landaux-poussettes', 'enfants-bebe', 'Landaux & poussettes');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-lits-b-b', 'enfants-bebe', 'Lits bébé');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-biberons', 'enfants-bebe', 'Biberons');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-produits-d-hygi-ne-b-b', 'enfants-bebe', 'Produits d''hygiène bébé');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('enfants-bebe-sacs-scolaires', 'enfants-bebe', 'Sacs scolaires');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-maquillage', 'beaute', 'Maquillage');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-fonds-de-teint', 'beaute', 'Fonds de teint');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-rouge-l-vres', 'beaute', 'Rouge à lèvres');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-cr-mes-visage', 'beaute', 'Crèmes visage');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-soins-peau', 'beaute', 'Soins peau');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-soins-cheveux', 'beaute', 'Soins cheveux');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-huiles-naturelles', 'beaute', 'Huiles naturelle');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-parfums-femme', 'beaute', 'Parfums femme');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-parfums-homme', 'beaute', 'Parfums homme');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-kits-beaut', 'beaute', 'Kits beauté');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('beaute-produits-bio', 'beaute', 'Produits bio');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sante-m-dicaments-otc', 'sante', 'Médicaments OTC');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sante-compl-ments-alimentaires', 'sante', 'Compléments alimentaires');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sante-mat-riel-m-dical', 'sante', 'Matériel médical');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sante-tensiom-tres', 'sante', 'Tensiomètres');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sante-thermom-tres', 'sante', 'Thermomètres');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sante-masques-protection', 'sante', 'Masques & protection');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sante-produits-hygi-ne', 'sante', 'Produits hygiène');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sante-dentifrice-brosses', 'sante', 'Dentifrice & brosses');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sante-d-sinfectants', 'sante', 'Désinfectants');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sante-premiers-soins', 'sante', 'Premiers soins');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-canap-s', 'maison-deco', 'Canapés');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-tables', 'maison-deco', 'Tables');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-chaises', 'maison-deco', 'Chaises');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-lits', 'maison-deco', 'Lits');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-matelas', 'maison-deco', 'Matelas');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-armoires', 'maison-deco', 'Armoires');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-rideaux', 'maison-deco', 'Rideaux');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-tapis', 'maison-deco', 'Tapis');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-d-coration-murale', 'maison-deco', 'Décoration murale');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-luminaires', 'maison-deco', 'Luminaires');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-lampes', 'maison-deco', 'Lampes');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-ustensiles-cuisine', 'maison-deco', 'Ustensiles cuisine');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-vaisselle', 'maison-deco', 'Vaisselle');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('maison-deco-rangements', 'maison-deco', 'Rangements');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-1-produits-secs', 'alimentation', '11.1 Produits secs');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-2-riz-c-r-ales', 'alimentation', '11.2 Riz & céréales');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-3-p-tes-alimentaires', 'alimentation', '11.3 Pâtes alimentaires');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-4-huiles-mati-res-grasses', 'alimentation', '11.4 Huiles & matières grasses');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-5-pices-condiments', 'alimentation', '11.5 Épices & condiments');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-6-boissons', 'alimentation', '11.6 Boissons');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-7-jus-naturels', 'alimentation', '11.7 Jus naturels');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-produits-frais', 'alimentation', '11.8 Produits frais');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-9-conserves-produits-longue-dur-e', 'alimentation', '11.9 Conserves & produits longue durée');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-10-snacks-confiseries', 'alimentation', '11.10 Snacks & confiseries');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-11-produits-b-b-alimentaires', 'alimentation', '11.11 Produits bébé (alimentaires)');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-12-produits-m-nagers', 'alimentation', '11.12 Produits ménagers');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('alimentation-11-13-produits-locaux-traditionnels', 'alimentation', '11.13 Produits locaux & traditionnels');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-fitness', 'sport', 'Fitness');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-musculation', 'sport', 'Musculation');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-halt-res', 'sport', 'Haltères');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-tapis-de-yoga', 'sport', 'Tapis de yoga');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-ballons', 'sport', 'Ballons');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-maillots-de-sport', 'sport', 'Maillots de sport');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-chaussures-de-sport', 'sport', 'Chaussures de sport');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-v-los', 'sport', 'Vélos');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-trottinettes', 'sport', 'Trottinettes');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-camping', 'sport', 'Camping');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-jeux-de-plein-air', 'sport', 'Jeux de plein air');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('sport-jeux-de-soci-t', 'sport', 'Jeux de société');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('gaming-consoles-de-jeux', 'gaming', 'Consoles de jeux');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('gaming-jeux-vid-o', 'gaming', 'Jeux vidéo');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('gaming-manettes', 'gaming', 'Manettes');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('gaming-casques-gaming', 'gaming', 'Casques gaming');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('gaming-accessoires-gaming', 'gaming', 'Accessoires gaming');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('gaming-pc-gaming', 'gaming', 'PC gaming');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('gaming-cartes-cadeaux', 'gaming', 'Cartes cadeaux');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('auto-moto-pi-ces-d-tach-es', 'auto-moto', 'Pièces détachées');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('auto-moto-accessoires-voiture', 'auto-moto', 'Accessoires voiture');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('auto-moto-accessoires-moto', 'auto-moto', 'Accessoires moto');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('auto-moto-pneus', 'auto-moto', 'Pneus');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('auto-moto-batteries-voiture', 'auto-moto', 'Batteries voiture');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('auto-moto-huiles-moteur', 'auto-moto', 'Huiles moteur');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('auto-moto-gps-voiture', 'auto-moto', 'GPS voiture');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('auto-moto-autoradios', 'auto-moto', 'Autoradios');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('auto-moto-casques-moto', 'auto-moto', 'Casques moto');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('auto-moto-quipements-s-curit', 'auto-moto', 'Équipements sécurité');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('bricolage-outils-manuels', 'bricolage', 'Outils manuels');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('bricolage-perceuses', 'bricolage', 'Perceuses');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('bricolage-marteaux', 'bricolage', 'Marteaux');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('bricolage-scies', 'bricolage', 'Scies');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('bricolage-tournevis', 'bricolage', 'Tournevis');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('bricolage-lectricit-b-timent', 'bricolage', 'Électricité bâtiment');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('bricolage-plomberie', 'bricolage', 'Plomberie');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('bricolage-peinture', 'bricolage', 'Peinture');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('bricolage-ciment-mat-riaux', 'bricolage', 'Ciment & matériaux');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('bricolage-vis-boulons', 'bricolage', 'Vis & boulons');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('librairie-livres-scolaires', 'librairie', 'Livres scolaires');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('librairie-romans', 'librairie', 'Romans');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('librairie-cahiers', 'librairie', 'Cahiers');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('librairie-stylos', 'librairie', 'Stylos');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('librairie-fournitures-bureau', 'librairie', 'Fournitures bureau');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('librairie-agenda', 'librairie', 'Agenda');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('librairie-sacs-scolaires', 'librairie', 'Sacs scolaires');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('librairie-mat-riel-artistique', 'librairie', 'Matériel artistique');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('musique-guitares', 'musique', 'Guitares');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('musique-pianos', 'musique', 'Pianos');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('musique-batteries', 'musique', 'Batteries');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('musique-microphones', 'musique', 'Microphones');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('musique-enceintes-musicales', 'musique', 'Enceintes musicales');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('musique-instruments-traditionnels', 'musique', 'Instruments traditionnels');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('musique-accessoires-musique', 'musique', 'Accessoires musique');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('voyage-valises', 'voyage', 'Valises');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('voyage-sacs-de-voyage', 'voyage', 'Sacs de voyage');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('voyage-sacs-dos', 'voyage', 'Sacs à dos');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('voyage-accessoires-voyage', 'voyage', 'Accessoires voyage');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('voyage-oreillers-de-voyage', 'voyage', 'Oreillers de voyage');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('services-livraison', 'services', 'Livraison');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('services-transport', 'services', 'Transport');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('services-r-paration-t-l-phone', 'services', 'Réparation téléphone');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('services-r-paration-lectrom-nager', 'services', 'Réparation électroménager');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('services-design-graphique', 'services', 'Design graphique');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('services-d-veloppement-web', 'services', 'Développement web');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('services-formation', 'services', 'Formation');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('services-coaching', 'services', 'Coaching');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('services-freelance-divers', 'services', 'Freelance divers');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('artisanat-artisanat-africain', 'artisanat', 'Artisanat africain');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('artisanat-pagnes-tissus', 'artisanat', 'Pagnes & tissus');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('artisanat-bijoux-artisanaux', 'artisanat', 'Bijoux artisanaux');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('artisanat-sculptures', 'artisanat', 'Sculptures');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('artisanat-produits-naturels', 'artisanat', 'Produits naturels');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('artisanat-cosm-tiques-locaux', 'artisanat', 'Cosmétiques locaux');
INSERT INTO ippoo_market_ref_categories (id, parent_id, name) VALUES ('artisanat-aliments-locaux', 'artisanat', 'Aliments locaux');

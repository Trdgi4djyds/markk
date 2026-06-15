-- Migration: Reference Tables for IPPOO Market
-- Description: Creates and populates reference tables for countries, categories, sectors, and more.

-- 1. Countries
CREATE TABLE IF NOT EXISTS ref_countries (
    iso CHAR(2) PRIMARY KEY,
    name TEXT NOT NULL,
    dial TEXT NOT NULL,
    nsn_min INTEGER NOT NULL,
    nsn_max INTEGER NOT NULL,
    example TEXT
);

-- 2. Categories (Hierarchical)
CREATE TABLE IF NOT EXISTS ref_categories (
    id TEXT PRIMARY KEY,
    parent_id TEXT REFERENCES ref_categories(id),
    code TEXT,
    icon TEXT,
    name TEXT NOT NULL,
    color TEXT,
    image TEXT
);

-- 3. Sectors, Subsectors and Niches
CREATE TABLE IF NOT EXISTS ref_sectors (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL,
    icon TEXT,
    description TEXT
);

CREATE TABLE IF NOT EXISTS ref_subsectors (
    id TEXT PRIMARY KEY,
    sector_id TEXT NOT NULL REFERENCES ref_sectors(id),
    label TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS ref_niches (
    id SERIAL PRIMARY KEY,
    sector_id TEXT NOT NULL REFERENCES ref_sectors(id),
    subsector_id TEXT NOT NULL REFERENCES ref_subsectors(id),
    label TEXT NOT NULL
);

-- 4. Business Circuits
CREATE TABLE IF NOT EXISTS ref_circuits (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL,
    description TEXT,
    icon TEXT
);

-- 5. Juridical Forms
CREATE TABLE IF NOT EXISTS ref_juridical_forms (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL
);

-- SEEDING DATA

-- Countries
INSERT INTO ref_countries (iso, name, dial, nsn_min, nsn_max, example) VALUES
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
INSERT INTO ref_sectors (id, label, icon, description) VALUES
('primaire', 'Secteur Primaire', '🌾', 'Agriculture, élevage, pêche, exploitation des ressources naturelles'),
('secondaire', 'Secteur Secondaire', '🏭', 'Transformation, artisanat, fabrication, industrie'),
('tertiaire', 'Secteur Tertiaire', '🛒', 'Commerce, distribution, logistique et services')
ON CONFLICT (id) DO NOTHING;

-- Subsectors
INSERT INTO ref_subsectors (id, sector_id, label) VALUES
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
INSERT INTO ref_circuits (id, label, description, icon) VALUES
('producteur', 'Producteur', 'Agriculture, élevage, pêche, coopératives', '🌿'),
('transformateur', 'Transformateur', 'Agro-transformation, artisanat, industrie', '🏭'),
('distributeur', 'Distributeur', 'Grossiste, semi-grossiste, importateur', '🚚'),
('revendeur', 'Revendeur / Commerçant', 'Boutique, supermarché, e-commerce', '🛒')
ON CONFLICT (id) DO NOTHING;

-- Juridical Forms
INSERT INTO ref_juridical_forms (id, label) VALUES
('individuelle', 'Entreprise individuelle (personne physique)'),
('ei', 'EI / Auto-entrepreneur'),
('sarl', 'SARL'),
('sa', 'SA'),
('cooperative', 'Coopérative'),
('association', 'Association'),
('gie', 'GIE (Groupement d''Intérêt Économique)'),
('autre', 'Autre')
ON CONFLICT (id) DO NOTHING;

-- Note: Categories and Niches seeding would be very large and are often managed via dedicated scripts or partial migrations.
-- I will include the top-level categories here as an example.

INSERT INTO ref_categories (id, parent_id, code, icon, name, color, image) VALUES
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
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de maïs');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de riz');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de sorgho');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de mil');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de niébé');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur de soja');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Cultivateur d''arachide');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur de manioc');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur d''igname');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur de patate douce');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur de taro');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur de banane plantain');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Jardinier vivrier');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-vivrieres', 'Producteur de légumes locaux');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de tomate');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de piment');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de poivron');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur d''oignon');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur d''ail');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de laitue');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de concombre');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de choux');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de carotte');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur d''aubergine africaine');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'maraichage', 'Producteur de feuilles (gboma, amarante, basilic, menthe)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''ananas');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur de mangue');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur d''orange');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur de citron');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur de goyave');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur de papaye');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur de pastèque');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur de banane douce');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'fruits', 'Producteur de noix de coco');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de coton');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de noix de cajou');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de palmier à huile');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de cacao');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de café');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de tabac');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'cultures-industrielles', 'Producteur de soja industriel');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur bovin');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur ovin');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur caprin');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur porcin');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur de chevaux');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'elevage-traditionnel', 'Éleveur d''ânes');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur poulets de chair');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur pondeuses');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur pintades');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur cailles');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur canards');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Éleveur dindons');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'aviculture', 'Producteur d''œufs');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'autres-elevages', 'Apiculteur');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'autres-elevages', 'Héliciculteur (escargots)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'autres-elevages', 'Cuniculture (lapins)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'autres-elevages', 'Éleveur de poissons (aquaculture)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Pêcheur artisanal');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Pêcheur lagunaire');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Pêcheur de rivière');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Pêcheur maritime (barques)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Poseur de nasses');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Fabricant de filets');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Mareyeur');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Fumeur de poisson');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Sécheur de poisson');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Vendeur de poisson frais');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Vendeur de crustacés');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'peche', 'Producteur d''écrevisses');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Charbonnier (fabrication charbon de bois)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Collecteur de bois de chauffe');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Exploitant de sable');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Exploitant de latérite');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Exploitant de gravier');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Cueilleur de plantes médicinales');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Collecteur de feuilles (palme, rônier)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Exploitant de fibres naturelles (raphia, bambou)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('primaire', 'ressources-naturelles', 'Producteur d''argile');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-manioc', 'Transformateur de gari');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-manioc', 'Transformateur de tapioca');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-manioc', 'Transformateur de cossettes');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-manioc', 'Producteur d''attiéké');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-manioc', 'Vente de pâte de manioc');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-cereales', 'Meunier');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-cereales', 'Transformateur de farine de maïs');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-cereales', 'Transformateur de farine de riz');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-cereales', 'Fabricant de akassa / pâte');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'transfo-cereales', 'Fabricant de bouillies locales');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'huiles', 'Producteur d''huile rouge');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'huiles', 'Producteur d''huile palmiste');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'huiles', 'Producteur d''huile d''arachide');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'huiles', 'Producteur d''huile de soja');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-animaux', 'Boucherie artisanale');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-animaux', 'Abattage informel');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-animaux', 'Charcutier traditionnel');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-laitiers', 'Producteur de fromage peulh');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-laitiers', 'Producteur de yaourt artisanal');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-laitiers', 'Producteur de lait caillé');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-sucres', 'Fabricant de jus locaux (gingembre, bissap, zobo)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-sucres', 'Fabricant de sirops');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'produits-sucres', 'Fabricant de confitures');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'boulangerie', 'Boulanger traditionnel');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'boulangerie', 'Fabricant de beignets');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'boulangerie', 'Fabricant de gâteaux locaux');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'boulangerie', 'Fabricant de galettes');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Soudeur');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Métallier');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Forgeron');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Fabricant de portails');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Fabricant d''outils agricoles');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Réparateur auto');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Réparateur moto');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Réparateur de vélos');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Bobineur');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'metal', 'Tôlier');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Menuisier bois');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Charpentier');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Fabricant de meubles');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Fabricant de lits');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Fabricant de tables');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'bois', 'Fabricant de portes');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Couturier');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Styliste');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Brodeur');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Tisserand');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Fabricant de pagnes tissés');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Fabricant de sacs artisanaux');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Fabricant de sandales en pagne');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'textile', 'Teinturière / batik');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cuir', 'Cordonnier');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cuir', 'Fabricant de chaussures');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cuir', 'Fabricant de ceintures');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cuir', 'Fabricant de sacs en cuir');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cosmetique', 'Savonnier (savon noir, savon de toilette)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cosmetique', 'Fabricant d''huiles naturelles (coco, karité, neem)');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cosmetique', 'Fabricant de pommades naturelles');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'cosmetique', 'Fabricant de parfums artisanaux');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'materiaux', 'Fabricant de briques en terre');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'materiaux', 'Fabricant de briques ciment');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'materiaux', 'Fabricant de carreaux artisanaux');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'materiaux', 'Fabricant de peintures locales');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Sculpteur');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Peintre sur toile');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Fabricant de bijoux');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Fabricant d''objets décoratifs');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Fabricant d''ustensiles traditionnels');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Fabricant de balais');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('secondaire', 'artisanat', 'Fabricant de paniers');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste céréales');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Semi-grossiste céréales');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste tubercules');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste volailles');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste poissons');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Dépôt d''œufs');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Dépôt de boissons');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Dépôt d''eau minérale');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste jus');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-alim', 'Grossiste fruits et légumes');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste produits cosmétiques');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste produits ménagers');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste chaussures');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste vêtements');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste sacs');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste pièces détachées moto');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste pièces détachées auto');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'grossiste-non-alim', 'Grossiste matériaux de construction');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur vivriers');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur légumes frais');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur poissons frais');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur poissons fumés');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur viandes');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur volailles');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur épices');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur huiles alimentaires');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur pains');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Revendeur boissons');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Marchande de beignets');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Marchande de bouillies');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-alim', 'Marchande de fruits');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de vêtements');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de friperie');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur d''articles pour bébés');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de sacs');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de téléphones');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de coques & accessoires');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur d''appareils électroménagers');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur d''ustensiles de cuisine');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de meubles d''occasion');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de tapis');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'commerce-non-alim', 'Vendeur de chaussures');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'transport', 'Conducteur de taxi-moto');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'transport', 'Conducteur taxi tricycle');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'transport', 'Conducteur taxi-bus');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'transport', 'Transporteur de marchandises');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'transport', 'Transporteur à tricycle cargo');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Coiffeuse');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Coiffeur');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Tresseuse');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Esthéticienne');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Maquilleuse');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Barbier');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-perso', 'Lavandière');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur téléphone');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur ordinateurs');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur électroménagers');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur télévision');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur ventilateurs');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur groupes électrogènes');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'reparation', 'Réparateur panneaux solaires');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Restauratrice de rue');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Vendeur de grillades');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Vendeur de brochettes');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Vendeur de sandwichs');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Vendeur de café / thé');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Gérant de maquis');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'restauration', 'Gérant de bar local');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Photographe');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Vidéaste');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Imprimeur de rue');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Agent de nettoyage');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Agent de gardiennage');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Laveur de vitres');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Laveur de motos');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Laveur de voitures');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Dépanneur rapide');
INSERT INTO ref_niches (sector_id, subsector_id, label) VALUES ('tertiaire', 'services-divers', 'Changeur de monnaie');

INSERT INTO ref_categories (id, parent_id, name) VALUES ('telephonie-t-l-phonie-objets-connect-s', 'telephonie', 'Téléphonie & Objets connectés');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('informatique-informatique-high-tech', 'informatique', 'Informatique & High-Tech');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('electronique-lectronique-multim-dia', 'electronique', 'Électronique & Multimédia');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('electromenager-lectrom-nager-maison', 'electromenager', 'Électroménager & Maison');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('mode-femme-mode-femme', 'mode-femme', 'Mode Femme');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('mode-homme-mode-homme', 'mode-homme', 'Mode Homme');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('enfants-bebe-enfants-b-b', 'enfants-bebe', 'Enfants & Bébé');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('beaute-beaut-cosm-tique', 'beaute', 'Beauté & Cosmétique');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('sante-sant-hygi-ne', 'sante', 'Santé & Hygiène');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('maison-deco-maison-d-coration', 'maison-deco', 'Maison & Décoration');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-alimentation-supermarch', 'alimentation', 'Alimentation & Supermarché');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-1-produits-secs', 'alimentation', '11.1 Produits secs');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-2-riz-c-r-ales', 'alimentation', '11.2 Riz & céréales');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-3-p-tes-alimentaires', 'alimentation', '11.3 Pâtes alimentaires');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-4-huiles-mati-res-grasses', 'alimentation', '11.4 Huiles & matières grasses');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-5-pices-condiments', 'alimentation', '11.5 Épices & condiments');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-6-boissons', 'alimentation', '11.6 Boissons');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-7-jus-naturels', 'alimentation', '11.7 Jus naturels');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-produits-frais', 'alimentation', '11.8 Produits frais');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-1-l-gumes-frais', 'alimentation', '11.8.1 Légumes frais');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-2-fruits-frais', 'alimentation', '11.8.2 Fruits frais');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-3-viandes-fra-ches', 'alimentation', '11.8.3 Viandes fraîches');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-4-poissons-frais', 'alimentation', '11.8.4 Poissons frais');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-5-fruits-de-mer', 'alimentation', '11.8.5 Fruits de mer');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-6-produits-laitiers-frais', 'alimentation', '11.8.6 Produits laitiers frais');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-7-produits-frais-locaux', 'alimentation', '11.8.7 Produits frais locaux');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-8-produits-frais-transform-s', 'alimentation', '11.8.8 Produits frais transformés');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-8-9-produits-frais-emball-s', 'alimentation', '11.8.9 Produits frais emballés');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-9-conserves-produits-longue-dur-e', 'alimentation', '11.9 Conserves & produits longue durée');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-10-snacks-confiseries', 'alimentation', '11.10 Snacks & confiseries');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-11-produits-b-b-alimentaires', 'alimentation', '11.11 Produits bébé (alimentaires)');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-12-produits-m-nagers', 'alimentation', '11.12 Produits ménagers');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('alimentation-11-13-produits-locaux-traditionnels', 'alimentation', '11.13 Produits locaux & traditionnels');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('sport-sport-loisirs', 'sport', 'Sport & Loisirs');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('gaming-gaming-loisirs-num-riques', 'gaming', 'Gaming & Loisirs numériques');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('auto-moto-auto-moto', 'auto-moto', 'Auto & Moto');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('bricolage-bricolage-construction', 'bricolage', 'Bricolage & Construction');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('librairie-librairie-papeterie', 'librairie', 'Librairie & Papeterie');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('musique-musique-instruments', 'musique', 'Musique & Instruments');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('voyage-voyage-bagagerie', 'voyage', 'Voyage & Bagagerie');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('services-services-marketplace-hybride', 'services', 'Services (Marketplace hybride)');
INSERT INTO ref_categories (id, parent_id, name) VALUES ('artisanat-produits-locaux-artisanat', 'artisanat', 'Produits locaux & artisanat');

-- Seeding data for IPPOO Market Reference Tables

-- 1. African Countries
INSERT INTO african_countries (iso, name, dial, nsn_min, nsn_max, example) VALUES
('BJ', 'Bénin', '229', 10, 12, '+229 01 91 00 00 00 00'),
('CI', 'Côte d''Ivoire', '225', 10, 10, '+225 01 23 45 67 89'),
('NG', 'Nigéria', '234', 10, 10, '+234 802 123 4567'),
('SN', 'Sénégal', '221', 9, 9, '+221 70 123 45 67'),
('TG', 'Togo', '228', 8, 8, '+228 90 11 23 45'),
('GH', 'Ghana', '233', 9, 9, '+233 23 123 4567'),
('BF', 'Burkina Faso', '226', 8, 8, '+226 70 12 34 56'),
('ML', 'Mali', '223', 8, 8, '+223 65 01 23 45'),
('NE', 'Niger', '227', 8, 8, '+227 90 12 34 56'),
('CM', 'Cameroun', '237', 9, 9, '+237 6 71 23 45 67')
ON CONFLICT (iso) DO NOTHING;

-- 2. Catalog Categories
INSERT INTO catalog_categories (id, code, name, icon, color, image_url) VALUES
('telephonie', '1', 'Téléphonie & Objets connectés', 'Smartphone', '#3B82F6', 'https://images.unsplash.com/photo-1719945421298-f03d3d80c3e1?auto=format&fit=crop&w=800&q=70'),
('informatique', '2', 'Informatique & High-Tech', 'Laptop', '#6366F1', 'https://images.unsplash.com/photo-1511385348-a52b4a160dc2?auto=format&fit=crop&w=800&q=70'),
('electronique', '3', 'Électronique & Multimédia', 'Tv', '#0EA5E9', 'https://images.unsplash.com/photo-1651340675491-6fb0bfb5c4ea?auto=format&fit=crop&w=800&q=70'),
('electromenager', '4', 'Électroménager & Maison', 'Refrigerator', '#9333EA', 'https://images.unsplash.com/photo-1721613877687-c9099b698faa?auto=format&fit=crop&w=800&q=70'),
('mode-femme', '5', 'Mode Femme', 'Shirt', '#EC4899', 'https://images.unsplash.com/photo-1532453288672-3a27e9be9efd?auto=format&fit=crop&w=800&q=70'),
('mode-homme', '6', 'Mode Homme', 'Shirt', '#1E40AF', 'https://images.unsplash.com/photo-1618886614638-80e3c103d31a?auto=format&fit=crop&w=800&q=70'),
('enfants-bebe', '7', 'Enfants & Bébé', 'Baby', '#FBBF24', 'https://images.unsplash.com/photo-1498940757830-82f7813bf178?auto=format&fit=crop&w=800&q=70'),
('beaute', '8', 'Beauté & Cosmétique', 'Sparkles', '#F0278E', 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?auto=format&fit=crop&w=800&q=70'),
('sante', '9', 'Santé & Hygiène', 'HeartPulse', '#10B981', 'https://images.unsplash.com/photo-1576602976047-174e57a47881?auto=format&fit=crop&w=800&q=70'),
('maison-deco', '10', 'Maison & Décoration', 'Sofa', '#16A34A', 'https://images.unsplash.com/photo-1558442074-3c19857bc1dc?auto=format&fit=crop&w=800&q=70'),
('alimentation', '11', 'Alimentation & Supermarché', 'UtensilsCrossed', '#FF6B00', 'https://images.unsplash.com/photo-1630960411440-10f7b59717ba?auto=format&fit=crop&w=800&q=70'),
('sport', '12', 'Sport & Loisirs', 'Dumbbell', '#F97316', 'https://images.unsplash.com/photo-1591311630200-ffa9120a540f?auto=format&fit=crop&w=800&q=70'),
('gaming', '13', 'Gaming & Loisirs numériques', 'Gamepad2', '#8B5CF6', 'https://images.unsplash.com/photo-1493711662062-fa541adb3fc8?auto=format&fit=crop&w=800&q=70'),
('auto-moto', '14', 'Auto & Moto', 'Car', '#DC2626', 'https://images.unsplash.com/photo-1625811485537-af2c05a0232d?auto=format&fit=crop&w=800&q=70'),
('bricolage', '15', 'Bricolage & Construction', 'Wrench', '#78716C', 'https://images.unsplash.com/photo-1426927308491-6380b6a9936f?auto=format&fit=crop&w=800&q=70'),
('librairie', '16', 'Librairie & Papeterie', 'BookOpen', '#6366F1', 'https://images.unsplash.com/photo-1532012197267-da84d127e765?auto=format&fit=crop&w=800&q=70'),
('musique', '17', 'Musique & Instruments', 'Music', '#A855F7', 'https://images.unsplash.com/photo-1510915361894-db8b60106cb1?auto=format&fit=crop&w=800&q=70'),
('voyage', '18', 'Voyage & Bagagerie', 'Luggage', '#0D9488', 'https://images.unsplash.com/photo-1639598003276-8a70fcaaad6c?auto=format&fit=crop&w=800&q=70'),
('services', '19', 'Services (Marketplace hybride)', 'Briefcase', '#0EA5E9', 'https://images.unsplash.com/photo-1549923746-c502d488b3ea?auto=format&fit=crop&w=800&q=70'),
('artisanat', '20', 'Produits locaux & artisanat', 'Palette', '#E8A817', 'https://images.unsplash.com/photo-1534413340928-7bd74b65196f?auto=format&fit=crop&w=800&q=70')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, icon = EXCLUDED.icon, color = EXCLUDED.color, image_url = EXCLUDED.image_url;

-- 4. Sectors
INSERT INTO sectors (id, label, icon, description) VALUES
('primaire', 'Secteur Primaire', '🌾', 'Agriculture, élevage, pêche, exploitation des ressources naturelles'),
('secondaire', 'Secteur Secondaire', '🏭', 'Transformation, artisanat, fabrication, industrie'),
('tertiaire', 'Secteur Tertiaire', '🛒', 'Commerce, distribution, logistique et services')
ON CONFLICT (id) DO UPDATE SET label = EXCLUDED.label, icon = EXCLUDED.icon, description = EXCLUDED.description;

-- 7. Business Circuits
INSERT INTO circuits (id, label, description, icon) VALUES
('producteur', 'Producteur', 'Agriculture, élevage, pêche, coopératives', '🌿'),
('transformateur', 'Transformateur', 'Agro-transformation, artisanat, industrie', '🏭'),
('distributeur', 'Distributeur', 'Grossiste, semi-grossiste, importateur', '🚚'),
('revendeur', 'Revendeur / Commerçant', 'Boutique, supermarché, e-commerce', '🛒')
ON CONFLICT (id) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, icon = EXCLUDED.icon;

-- 8. Juridical Forms
INSERT INTO juridical_forms (id, label) VALUES
('individuelle', 'Entreprise individuelle (personne physique)'),
('ei', 'EI / Auto-entrepreneur'),
('sarl', 'SARL'),
('sa', 'SA'),
('cooperative', 'Coopérative'),
('association', 'Association'),
('gie', 'GIE (Groupement d''Intérêt Économique)'),
('autre', 'Autre')
ON CONFLICT (id) DO NOTHING;

-- 9. Product Units
INSERT INTO product_units (id, label) VALUES
('unités', 'unités'),
('cartons', 'cartons'),
('sacs', 'sacs'),
('lots', 'lots'),
('pièces', 'pièces'),
('kg', 'kg'),
('litres', 'litres')
ON CONFLICT (id) DO NOTHING;

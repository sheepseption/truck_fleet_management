-- ============================================================
--    suppression des donnees
-- ============================================================

TRUNCATE personnel, camion, produit, depot, livraison, contenir, gerer, admin, chauffeur, infraction;

-- ============================================================
--    creation des donnees
-- ============================================================

-- PERSONNEL
INSERT INTO Personnel (Identifiant, Nom, Prenom, Adresse, Ville, Anciennete, Absence) VALUES
(1, 'Dupont', 'Jean', '123 Rue Principale', 'Ville A', 5, 0),
(2, 'Martin', 'Claire', '456 Avenue Secondaire', 'Ville B', 3, 0),
(3, 'Bernard', 'Luc', '789 Boulevard Tertiaire', 'Ville C', 2, 0);

-- CHAUFFEUR
INSERT INTO Chauffeur (Identifiant, Type_permis) VALUES
(3, 'Permis B'),
(1, 'Permis C');

-- ADMIN
INSERT INTO Admin (Identifiant, Poste) VALUES
(2, 'Responsable');

-- MODELE
INSERT INTO Modele (Numero_modele, Marque, Type_vehicule, Capacite) VALUES
(101, 'Volvo FH', 'Camion', 20000),
(102, 'Mercedes Actros', 'Camion', 25000),
(103, 'Scania R450', 'Camion', 30000);

-- CAMION
INSERT INTO Camion (Immatriculation, Date_mise_en_service, Date_achat, Kilometrage, Etat, Kilometrage_vidange, Date_controle_technique, Numero_modele) VALUES
('AB-123-CD', '2024-01-01', '2024-01-01', 10000, 'Disponible', 5000, '2024-01-01', 101),
('EF-456-GH', '2024-01-01', '2024-01-01', 20000, 'En Maintenance', 10000, '2024-01-01', 102),
('IJ-789-KL', '2024-01-01', '2024-01-01', 30000, 'Disponible', 15000, '2024-01-01', 103);

-- LIVRAISON
INSERT INTO Livraison (Reference, Date_livraison, Qualite_livraison, Immatriculation, Identifiant, Numero_depot_entrant, Numero_depot_sortant) VALUES
('AB-123-CD-2024-10-28', '2024-10-28', 'Bonne', 'AB-123-CD', 1, 301, 302),
('EF-456-GH-2024-10-29', '2024-10-29', 'Mauvaise', 'EF-456-GH', 2, 302, 301);

-- PRODUIT
INSERT INTO Produit (Code_produit, Nom_produit, Poids) VALUES
('PROD-1', 'Ordinateur Portable', 1.5),
('PROD-2', 'Table', 10.0),
('PROD-3', 'Smartphone', 0.3);

-- DEPOT
INSERT INTO Depot (Numero_depot, Nom_depot, Ville) VALUES
(301, 'Depot Central', 'Ville A'),
(302, 'Depot Sud', 'Ville B');

-- INFRACTION
INSERT INTO Infraction (Type) VALUES
('Excès de vitesse'),
('Stationnement illégal');

-- STOCKER
INSERT INTO Stocker (Numero_depot, Code_produit, Quantite_stockee) VALUES
(301, 'PROD-1', 100),
(301, 'PROD-2', 50),
(302, 'PROD-3', 200),
(302, 'PROD-1', 150),
(302, 'PROD-2', 100);

-- COMMETTRE
INSERT INTO Commettre (Identifiant, Type, Date) VALUES
(1, 'Excès de vitesse', '2024-09-15'),
(1, 'Stationnement illégal', '2024-10-01'),
(2, 'Excès de vitesse', '2024-09-15'),
(2, 'Stationnement illégal', '2024-10-01'),
(3, 'Excès de vitesse', '2024-09-15'),
(3, 'Stationnement illégal', '2024-10-01');

-- MANAGER
INSERT INTO Manager (Identifiant_admin, Identifiant_personnel) VALUES
(2, 1),
(2, 2);

-- GERER
INSERT INTO Gerer (Identifiant, Reference) VALUES
(301, 'AB-123-CD-2024-10-28'),
(302, 'EF-456-GH-2024-10-29');

-- CONTENIR
INSERT INTO Contenir (Reference, Code_produit, Quantite_livree) VALUES 
('AB-123-CD-2024-10-28', 'PROD-1', 100),
('AB-123-CD-2024-10-28', 'PROD-2', 50),
('EF-456-GH-2024-10-29', 'PROD-3', 200);
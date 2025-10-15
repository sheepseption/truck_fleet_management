
-- ============================================================
--    creation des donnees
-- ============================================================

-- PERSONNEL
INSERT INTO Personnel (Identifiant, Nom, Prenom, Adresse, Ville_personnel, Anciennete, Absence) VALUES
(1, 'Dupont', 'Jean', '123 Rue Principale', 'Ville A', 5, 1),
(2, 'Martin', 'Claire', '456 Avenue Secondaire', 'Ville B', 3, 0),
(3, 'Bernard', 'Luc', '789 Boulevard Tertiaire', 'Ville C', 2, 4),
(4, 'Durand', 'Marie', '1011 Chemin Quaternaire', 'Ville D', 1, 6),
(5, 'Lefevre', 'Paul', '1213 Route Cinquième', 'Ville C', 4, 2),
(6, 'Leroy', 'Sophie', '1415 Impasse Sixième', 'Ville B', 6, 12);

-- CHAUFFEUR
INSERT INTO Chauffeur (Identifiant, Type_permis) VALUES
(3, 'B'),
(1, 'C'),
(5, 'C'),
(6, 'A');

-- ADMIN
INSERT INTO Admin (Identifiant, Poste) VALUES
(2, 'Responsable'),
(4, 'Gestionnaire');

-- MODELE
INSERT INTO Modele (Numero_modele, Marque, Type_vehicule, Capacité) VALUES
(101, 'Volvo FH', 'Camion', 20000),
(102, 'Mercedes Actros', 'Camion', 25000),
(103, 'Scania R450', 'Camion', 30000),
(104, 'Renault T', 'Camion', 35000),
(105, 'Iveco S-Way', 'Camion', 40000),
(106, 'DAF XF', 'Camion', 45000);

-- CAMION
INSERT INTO Camion (Immatriculation, Date_mise_en_service, Date_achat, Kilometrage, Etat, Kilometrage_vidange, Date_controle_technique, Numero_modele) VALUES
('AB-123-CD', '2024-01-01', '2024-01-01', 10000, 'Disponible', 5000, '2024-01-01', 101),
('EF-456-GH', '2024-01-01', '2024-01-01', 20000, 'En Maintenance', 10000, '2024-01-01', 102),
('IJ-789-KL', '2024-01-01', '2024-01-01', 30000, 'Disponible', 15000, '2024-01-01', 103),
('MN-101-OP', '2024-01-01', '2024-01-01', 40000, 'En Panne', 20000, '2024-01-01', 104),
('QR-121-RS', '2024-01-01', '2024-01-01', 50000, 'Disponible', 25000, '2024-01-01', 105),
('TU-141-VW', '2024-01-01', '2024-01-01', 60000, 'En Maintenance', 30000, '2024-01-01', 106);

-- DEPOT
INSERT INTO Depot (Numero_depot, Nom_depot, Ville_depot) VALUES
(301, 'Depot Central', 'Ville A'),
(302, 'Depot Sud', 'Ville B'),
(303, 'Depot Central', 'Ville C'),
(304, 'Depot Nord', 'Ville C'),
(305, 'Depot Est', 'Ville D'),
(306, 'Depot Ouest', 'Ville D'),
(307, 'Depot Sud', 'Ville A'),
(308, 'Depot Nord', 'Ville B');

-- LIVRAISON
INSERT INTO Livraison (Reference, Date_livraison, Qualite_livraison, Immatriculation, Identifiant, Numero_depot_entrant, Numero_depot_sortant) VALUES
('AB-123-CD-2024-10-28', '2024-10-28', 'Terrible', 'AB-123-CD', 1, 301, 302),
('EF-456-GH-2024-10-29', '2024-10-29', 'Bonne', 'EF-456-GH', 3, 302, 301),
('IJ-789-KL-2024-10-30', '2024-10-30', 'Moyenne', 'IJ-789-KL', 5, 303, 304),
('MN-101-OP-2024-10-31', '2024-10-31', 'Mauvaise', 'MN-101-OP', 6, 304, 303),
('QR-121-RS-2024-11-01', '2024-11-01', 'Bonne', 'QR-121-RS', 1, 305, 306),
('TU-141-VW-2024-11-02', '2024-11-02', 'Moyenne', 'TU-141-VW', 3, 306, 305),
('AB-123-CD-2024-11-03', '2024-11-03', 'Terrible', 'AB-123-CD', 5, 301, 302),
('EF-456-GH-2024-11-04', '2024-11-04', 'Bonne', 'EF-456-GH', 6, 302, 301),
('IJ-789-KL-2024-11-05', '2024-11-05', 'Moyenne', 'IJ-789-KL', 1, 303, 304),
('MN-101-OP-2024-11-06', '2024-11-06', 'Mauvaise', 'MN-101-OP', 3, 304, 303),
('QR-121-RS-2024-11-07', '2024-11-07', 'Bonne', 'QR-121-RS', 5, 305, 306),
('TU-141-VW-2024-11-08', '2024-11-08', 'Moyenne', 'TU-141-VW', 6, 306, 305),
('AB-123-CD-2024-11-09', '2024-11-09', 'Terrible', 'AB-123-CD', 1, 301, 302),
('EF-456-GH-2024-11-10', '2024-11-10', 'Bonne', 'EF-456-GH', 3, 302, 301),
('IJ-789-KL-2024-11-11', '2024-11-11', 'Moyenne', 'IJ-789-KL', 5, 303, 304),
('MN-101-OP-2024-11-12', '2024-11-12', 'Mauvaise', 'MN-101-OP', 6, 304, 303),
('QR-121-RS-2024-11-13', '2024-11-13', 'Bonne', 'QR-121-RS', 1, 305, 306),
('TU-141-VW-2024-11-14', '2024-11-14', 'Moyenne', 'TU-141-VW', 3, 306, 305),
('AB-123-CD-2024-11-15', '2024-11-15', 'Terrible', 'AB-123-CD', 5, 301, 302),
('EF-456-GH-2024-11-16', '2024-11-16', 'Bonne', 'EF-456-GH', 6, 302, 301),
('IJ-789-KL-2024-11-17', '2024-11-17', 'Moyenne', 'IJ-789-KL', 1, 303, 304),
('MN-101-OP-2024-11-18', '2024-11-18', 'Mauvaise', 'MN-101-OP', 3, 304, 303),
('QR-121-RS-2024-11-19', '2024-11-19', 'Bonne', 'QR-121-RS', 5, 305, 306),
('TU-141-VW-2024-11-20', '2024-11-20', 'Moyenne', 'TU-141-VW', 6, 306, 305);

-- PRODUIT
INSERT INTO Produit (Code_produit, Nom_produit, Poids) VALUES
('PROD-1', 'Ordinateur Portable', 1.5),
('PROD-2', 'Table', 10.0),
('PROD-3', 'Smartphone', 0.3);

-- INFRACTION
INSERT INTO Infraction (Type) VALUES
('Excès de vitesse'),
('Stationnement illégal');

-- STOCKER
INSERT INTO Stocker (Numero_depot, Code_produit, Quantite_stockee) VALUES
(301, 'PROD-1', 1000),
(301, 'PROD-2', 500),
(302, 'PROD-3', 2000),
(302, 'PROD-1', 1050),
(302, 'PROD-2', 1000),
(303, 'PROD-1', 1000),
(303, 'PROD-2', 500),
(304, 'PROD-3', 2000),
(304, 'PROD-1', 1050),
(304, 'PROD-2', 1000),
(305, 'PROD-1', 1000),
(305, 'PROD-2', 500),
(305, 'PROD-3', 1041),
(306, 'PROD-3', 2000),
(306, 'PROD-1', 1050),
(306, 'PROD-2', 1000);

-- COMMETTRE
INSERT INTO Commettre (Identifiant, Type, Date) VALUES
(1, 'Excès de vitesse', '2024-09-15 10:01:00'),
(1, 'Stationnement illégal', '2024-10-01 12:41:00'),
(3, 'Excès de vitesse', '2024-09-12 08:15:00'),
(3, 'Stationnement illégal', '2024-10-02 14:30:00'),
(5, 'Excès de vitesse', '2024-09-10 09:30:00'),
(5, 'Stationnement illégal', '2024-10-03 16:00:00');

-- MANAGER
INSERT INTO Manager (Identifiant_admin, Identifiant_chauffeur) VALUES
(2, 1),
(2, 3),
(4, 5),
(4, 6);

-- GERER
INSERT INTO Gerer (Identifiant, Reference) VALUES
(2, 'AB-123-CD-2024-10-28'),
(2, 'EF-456-GH-2024-10-29'),
(4, 'IJ-789-KL-2024-10-30'),
(4, 'MN-101-OP-2024-10-31'),
(2, 'QR-121-RS-2024-11-01'),
(2, 'TU-141-VW-2024-11-02'),
(4, 'AB-123-CD-2024-11-03'),
(4, 'EF-456-GH-2024-11-04'),
(2, 'IJ-789-KL-2024-11-05'),
(2, 'MN-101-OP-2024-11-06'),
(4, 'QR-121-RS-2024-11-07'),
(4, 'TU-141-VW-2024-11-08'),
(2, 'AB-123-CD-2024-11-09'),
(2, 'EF-456-GH-2024-11-10'),
(4, 'IJ-789-KL-2024-11-11'),
(4, 'MN-101-OP-2024-11-12'),
(2, 'QR-121-RS-2024-11-13'),
(2, 'TU-141-VW-2024-11-14'),
(4, 'AB-123-CD-2024-11-15'),
(4, 'EF-456-GH-2024-11-16'),
(2, 'IJ-789-KL-2024-11-17'),
(2, 'MN-101-OP-2024-11-18'),
(4, 'QR-121-RS-2024-11-19'),
(4, 'TU-141-VW-2024-11-20');

-- CONTENIR
INSERT INTO Contenir (Reference, Code_produit, Quantite_livree) VALUES 
('AB-123-CD-2024-10-28', 'PROD-1', 100),
('AB-123-CD-2024-10-28', 'PROD-2', 50),
('EF-456-GH-2024-10-29', 'PROD-3', 200),
('EF-456-GH-2024-10-29', 'PROD-1', 150),
('EF-456-GH-2024-10-29', 'PROD-2', 100),
('IJ-789-KL-2024-10-30', 'PROD-1', 100),
('IJ-789-KL-2024-10-30', 'PROD-2', 50),
('MN-101-OP-2024-10-31', 'PROD-3', 200),
('MN-101-OP-2024-10-31', 'PROD-1', 150),
('MN-101-OP-2024-10-31', 'PROD-2', 100),
('QR-121-RS-2024-11-01', 'PROD-1', 100),
('QR-121-RS-2024-11-01', 'PROD-2', 50),
('TU-141-VW-2024-11-02', 'PROD-3', 200),
('TU-141-VW-2024-11-02', 'PROD-1', 150),
('TU-141-VW-2024-11-02', 'PROD-2', 100),
('AB-123-CD-2024-11-03', 'PROD-1', 100),
('AB-123-CD-2024-11-03', 'PROD-2', 50),
('EF-456-GH-2024-11-04', 'PROD-3', 200),
('EF-456-GH-2024-11-04', 'PROD-1', 150),
('EF-456-GH-2024-11-04', 'PROD-2', 100),
('IJ-789-KL-2024-11-05', 'PROD-1', 100),
('IJ-789-KL-2024-11-05', 'PROD-2', 50),
('MN-101-OP-2024-11-06', 'PROD-3', 200),
('MN-101-OP-2024-11-06', 'PROD-1', 150),
('MN-101-OP-2024-11-06', 'PROD-2', 100),
('QR-121-RS-2024-11-07', 'PROD-1', 100),
('QR-121-RS-2024-11-07', 'PROD-3', 141),
('TU-141-VW-2024-11-08', 'PROD-3', 200),
('TU-141-VW-2024-11-08', 'PROD-1', 150),
('TU-141-VW-2024-11-08', 'PROD-2', 100),
('AB-123-CD-2024-11-09', 'PROD-1', 100),
('AB-123-CD-2024-11-09', 'PROD-2', 50),
('EF-456-GH-2024-11-10', 'PROD-3', 200),
('EF-456-GH-2024-11-10', 'PROD-1', 150),
('EF-456-GH-2024-11-10', 'PROD-2', 100),
('IJ-789-KL-2024-11-11', 'PROD-1', 100),
('IJ-789-KL-2024-11-11', 'PROD-2', 50),
('MN-101-OP-2024-11-12', 'PROD-3', 200),
('MN-101-OP-2024-11-12', 'PROD-1', 150),
('MN-101-OP-2024-11-12', 'PROD-2', 100),
('QR-121-RS-2024-11-13', 'PROD-1', 100),
('QR-121-RS-2024-11-13', 'PROD-3', 141),
('TU-141-VW-2024-11-14', 'PROD-3', 200),
('TU-141-VW-2024-11-14', 'PROD-1', 150),
('TU-141-VW-2024-11-14', 'PROD-2', 100),
('AB-123-CD-2024-11-15', 'PROD-1', 100),
('AB-123-CD-2024-11-15', 'PROD-2', 50),
('EF-456-GH-2024-11-16', 'PROD-3', 200),
('EF-456-GH-2024-11-16', 'PROD-1', 150),
('EF-456-GH-2024-11-16', 'PROD-2', 100),
('IJ-789-KL-2024-11-17', 'PROD-1', 100),
('IJ-789-KL-2024-11-17', 'PROD-2', 50),
('MN-101-OP-2024-11-18', 'PROD-3', 200),
('MN-101-OP-2024-11-18', 'PROD-1', 150),
('MN-101-OP-2024-11-18', 'PROD-2', 100),
('QR-121-RS-2024-11-19', 'PROD-1', 100),
('QR-121-RS-2024-11-19', 'PROD-3', 141),
('TU-141-VW-2024-11-20', 'PROD-3', 200),
('TU-141-VW-2024-11-20', 'PROD-1', 150),
('TU-141-VW-2024-11-20', 'PROD-2', 100);

-- DISTANCE
INSERT INTO Distance (DepotA, DepotB, Distance) VALUES
--(DepotA, DepotB, random number)
(301,302, 114),
(302,301, 114),
(301,303, 214),
(303,301, 214),
(301,304, 82),
(304,301, 82),
(302,303, 506),
(303,302, 506),
(302,304, 401),
(304,302, 401),
(303,304, 18),
(304,303, 18),
(301,305, 714),
(305,301, 714),
(301,306, 97),
(306,301, 97),
(302,305, 145),
(305,302, 145),
(302,306, 102),
(306,302, 102),
(303,305, 134),
(305,303, 134),
(303,306, 515),
(306,303, 515),
(304,305, 141),
(305,304, 141),
(304,306, 165),
(306,304, 165);

INSERT INTO Parking (Depot, Immatriculation, Date_Commencement, Date_fin) VALUES
(306, 'AB-123-CD', '2024-09-28', '2024-10-02'),
(304, 'EF-456-GH', '2024-09-29', '2024-10-03'),
(305, 'IJ-789-KL', '2024-09-30', '2024-10-04'),
(303, 'MN-101-OP', '2024-10-01', '2024-10-05'),
(301, 'QR-121-RS', '2024-10-02', '2024-10-06'),
(302, 'TU-141-VW', '2024-10-03', '2024-10-07');
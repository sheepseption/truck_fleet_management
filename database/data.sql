-- ============================================================
-- Sample data for LOGISTIQUES database
-- ============================================================

-- Table: Personnel
INSERT INTO Personnel (Identifiant, Nom, Prenom, Adresse, Ville_personnel, Anciennete, Absence) VALUES
(1, 'Dupont', 'Jean', '123 Rue de Paris', 'Paris', 5, 2),
(2, 'Martin', 'Sophie', '45 Avenue des Champs', 'Lyon', 3, 1),
(3, 'Bernard', 'Luc', '78 Boulevard des Italiens', 'Marseille', 7, 0);


-- Table: Chauffeur
INSERT INTO Chauffeur (Identifiant, Type_permis) VALUES
(1, 'B'),
(3, 'C');

-- Table: Admin
INSERT INTO Admin (Identifiant, Poste) VALUES
(2, 'Directeur Logistique');

-- Table: Modele
INSERT INTO Modele (Numero_modele, Marque, Type_vehicule, Capacité) VALUES
(101, 'Renault', 'Camion', 2000),
(102, 'Mercedes', 'Fourgon', 1500);

-- Table: Camion
INSERT INTO Camion (Immatriculation, Date_mise_en_service, Date_achat, Kilometrage, Etat, Kilometrage_vidange, Date_controle_technique, Numero_modele) VALUES
('AB-123-CD', '2022-03-15', '2022-03-01', 50000, 'Bon', 10000, '2024-03-15', 101),
('EF-456-GH', '2023-01-10', '2023-01-01', 25000, 'Excellent', 5000, '2025-01-10', 102);

-- Table: Depot
INSERT INTO Depot (Numero_depot, Nom_depot, Ville_depot) VALUES
(1, 'Depot Central', 'Paris'),
(2, 'Depot Sud', 'Marseille');


-- Table: Livraison
INSERT INTO Livraison (Reference, Date_livraison, Qualite_livraison, Immatriculation, Identifiant, Numero_depot_entrant, Numero_depot_sortant) VALUES
('LIV001', '2024-05-20', 'Satisfaisant', 'AB-123-CD', 1, 1, 2),
('LIV002', '2024-06-15', 'Excellent', 'EF-456-GH', 3, 2, 1);

-- Table: Produit
INSERT INTO Produit (Code_produit, Nom_produit, Poids) VALUES
('P001', 'Ordinateur', 2.5),
('P002', 'Imprimante', 7.0);

-- Table: Infraction
INSERT INTO Infraction (Type) VALUES
('Excès de vitesse'),
('Non-respect des distances de sécurité');

-- Table: Stocker
INSERT INTO Stocker (Numero_depot, Code_produit, Quantite_stockee) VALUES
(1, 'P001', 50),
(2, 'P002', 30);

-- Table: Commettre (Un chauffeur commet une infraction)
INSERT INTO Commettre (Identifiant, Type, Date) VALUES
(1, 'Excès de vitesse', '2024-03-10'),
(3, 'Non-respect des distances de sécurité', '2024-04-12');

-- Table: Manager (Un admin manage les chauffeurs)
INSERT INTO Manager (Identifiant_admin, Identifiant_chauffeur) VALUES
(2, 1),
(2, 3);

-- Table: Gerer (Un admin gère les livraisons)
INSERT INTO Gerer (Identifiant, Reference) VALUES
(2, 'LIV001'),
(2, 'LIV002');

-- Table: Contenir (Une livraison contient des produits)
INSERT INTO Contenir (Reference, Code_produit, Quantite_livree) VALUES
('LIV001', 'P001', 20),
('LIV002', 'P002', 10);

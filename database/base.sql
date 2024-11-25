-- ============================================================

--   Nom de la base   :  LOGISTIQUES                                

--   Nom de SGBD      :  PostgreSQL                   

--   Date de creation :  26/10/2024                       

-- ============================================================

DROP TABLE IF EXISTS Commettre;
DROP TABLE IF EXISTS Stocker;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Chauffeur;
DROP TABLE IF EXISTS Infraction; 
DROP TABLE IF EXISTS Depot;
DROP TABLE IF EXISTS Produit;
DROP TABLE IF EXISTS Livraison;
DROP TABLE IF EXISTS Camion;
DROP TABLE IF EXISTS Personnel;
DROP TABLE IF EXISTS Modele;
DROP TABLE IF EXISTS Manager;
DROP TABLE IF EXISTS Gerer;
DROP TABLE IF EXISTS Contenir;

-- ============================================================
--   Table : PERSONNEL                                            
-- ============================================================
CREATE TABLE Personnel (
    Identifiant INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Adresse VARCHAR(100),
    Ville_personnel VARCHAR(50),
    Anciennete INT,
    Absence INT
);

-- ============================================================
--   Table : CHAUFFEUR (Hérite de personnel)                           
-- ============================================================
CREATE TABLE Chauffeur (
    Identifiant INT PRIMARY KEY,
    Type_permis VARCHAR(20),
    FOREIGN KEY (Identifiant) REFERENCES Personnel(Identifiant)
);

-- ============================================================
--   Table : ADMIN (Hérite de personnel)                                  
-- ============================================================
CREATE TABLE Admin (
    Identifiant INT PRIMARY KEY,
    Poste VARCHAR(50),
    FOREIGN KEY (Identifiant) REFERENCES Personnel(Identifiant)
);

-- ============================================================
--   Table : MODÈLE                                            
-- ============================================================
CREATE TABLE Modele (
    Numero_modele INT PRIMARY KEY,
    Marque VARCHAR(25),
    Type_vehicule VARCHAR(25),
    Capacité INT
);

-- ============================================================
--   Table : CAMION                                            
-- ============================================================
CREATE TABLE Camion (
    Immatriculation VARCHAR(20) PRIMARY KEY,
    Date_mise_en_service DATE,
    Date_achat DATE,
    Kilometrage INT,
    Etat VARCHAR(50),
    Kilometrage_vidange INT,
    Date_controle_technique DATE,
    Numero_modele INT,
    FOREIGN KEY (Numero_modele) REFERENCES Modele(Numero_modele)
);

-- ============================================================
--   Table : DEPÔT                                            
-- ============================================================
CREATE TABLE Depot (
    Numero_depot INT PRIMARY KEY,
    Nom_depot VARCHAR(50),
    Ville_depot VARCHAR(50)
);

-- ============================================================
--   Table : LIVRAISON                                            
-- ============================================================
CREATE TABLE Livraison (
    Reference VARCHAR(20) PRIMARY KEY,
    Date_livraison DATE,
    Qualite_livraison VARCHAR(50),
    Immatriculation VARCHAR(20) NOT NULL,
    Identifiant INT NOT NULL,
    Numero_depot_entrant INT NOT NULL,
    Numero_depot_sortant INT NOT NULL,
    FOREIGN KEY (Immatriculation) REFERENCES Camion(Immatriculation),
    FOREIGN KEY (Identifiant) REFERENCES Chauffeur(Identifiant),
    FOREIGN KEY (Numero_depot_entrant) REFERENCES Depot(Numero_depot),
    FOREIGN KEY (Numero_depot_sortant) REFERENCES Depot(Numero_depot)
);

-- ============================================================
--   Table : PRODUIT                                           
-- ============================================================
CREATE TABLE Produit (
    Code_produit VARCHAR(20) PRIMARY KEY,
    Nom_produit VARCHAR(50),
    Poids DECIMAL(10, 2)
);

-- ============================================================
--   Table : INFRACTION                                           
-- ============================================================
CREATE TABLE Infraction (
    Type VARCHAR(50) PRIMARY KEY
);

-- ============================================================
--   Table : STOCKER                                            
-- ============================================================
CREATE TABLE Stocker (
    Numero_depot INT,
    Code_produit VARCHAR(20),
    Quantite_stockee INT,
    PRIMARY KEY (Numero_depot, Code_produit),
    FOREIGN KEY (Numero_depot) REFERENCES Depot(Numero_depot),
    FOREIGN KEY (Code_produit) REFERENCES Produit(Code_produit)
);


-- ============================================================
--   Table : COMMETTRE (Un chauffeur commet une infraction)                                            
-- ============================================================
CREATE TABLE Commettre (
    Identifiant INT,
    Type VARCHAR(50),
    Date DATE,
    PRIMARY KEY (Identifiant, Type),
    FOREIGN KEY (Identifiant) REFERENCES Chauffeur(Identifiant),
    FOREIGN KEY (Type) REFERENCES Infraction(Type)
);

-- ============================================================
--   Table : MANAGE (Un admin manage les chaufeur)                                            
-- ============================================================
CREATE TABLE Manager (
    Identifiant_admin INT,
    Identifiant_chauffeur INT,
    PRIMARY KEY (Identifiant_admin, Identifiant_chauffeur),
    FOREIGN KEY (Identifiant_chauffeur) REFERENCES Chauffeur(Identifiant),
    FOREIGN KEY (Identifiant_admin) REFERENCES Admin(Identifiant)
    /*FOREIGN KEY (Identifiant_admin, Identifiant_chauffeur)*/
);

-- ============================================================
--   Table : GERER (Un admin gère les livraisons)                                            
-- ============================================================
CREATE TABLE Gerer (
    Identifiant INT, 
    Reference VARCHAR(20),
    PRIMARY KEY (Identifiant, Reference),
    -- FOREIGN KEY (Identifiant, Reference) doesn't provide a reference to a table
    FOREIGN KEY (Identifiant) REFERENCES Admin(Identifiant),
    FOREIGN KEY (Reference) REFERENCES Livraison(Reference)
);

-- ============================================================
--   Table : CONTENIR (Une livraison contient des produits)                                            
-- ============================================================
CREATE TABLE Contenir (
    Reference VARCHAR(20),
    Code_produit VARCHAR(20),
    Quantite_livree INT,
    PRIMARY KEY (Reference, Code_produit),
    FOREIGN KEY (Reference) REFERENCES Livraison(Reference),
    FOREIGN KEY (Code_produit) REFERENCES Produit(Code_produit)
    -- FOREIGN KEY (Reference, Code_produit) doesn't provide a reference to a table
);


-- ============================================================
--   Table : DISTANCE                                           
-- ============================================================
CREATE TABLE Distance (
    DepotA INT,
    DepotB INT,
    Distance DECIMAL(10,2),
    PRIMARY KEY (DepotA, DepotB),
    FOREIGN KEY (DepotA) REFERENCES Depot(Numero_depot),
    FOREIGN KEY (DepotB) REFERENCES Depot(Numero_depot),
    
);



-- ============================================================
--   Table : PARKING                                          
-- ============================================================
/*CREATE TABLE Parking (
    Ville_parking VARCHAR(50),
    DepotB INT,
    
    FOREIGN KEY (DepotA) REFERENCES Depot(Numero_depot),
    FOREIGN KEY (DepotB) REFERENCES Depot(Numero_depot),
    
);*/
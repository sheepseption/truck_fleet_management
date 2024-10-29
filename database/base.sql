-- ============================================================

--   Nom de la base   :  LOGISTIQUES                                

--   Nom de SGBD      :  PostgreSQL                   

--   Date de creation :  26/10/2024                       

-- ============================================================

DROP TABLE IF EXISTS Livrer; --pourquoi??
DROP TABLE IF EXISTS Recevoir; --?
DROP TABLE IF EXISTS Commettre;
DROP TABLE IF EXISTS Transporter; --?
DROP TABLE IF EXISTS Stocker;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Chauffeur;
DROP TABLE IF EXISTS Infraction; 
DROP TABLE IF EXISTS Depot;
DROP TABLE IF EXISTS Produit;
DROP TABLE IF EXISTS Livraison;
DROP TABLE IF EXISTS Camion;
DROP TABLE IF EXISTS Personnel;
-- il manque : manager - gérer - contenir

-- ============================================================

--   Table : PERSONNEL                                            

-- ============================================================
CREATE TABLE Personnel (
    Identifiant INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Adresse VARCHAR(100),
    Ville VARCHAR(50),
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

--   Table : CAMION                                            

-- ============================================================
CREATE TABLE Camion (
    Immatriculation VARCHAR(20) PRIMARY KEY,
    Date_mise_en_service DATE,
    Date_achat DATE,
    Kilometrage INT,
    Etat VARCHAR(50),
    Kilometrage_vidange INT,
    Date_controle_technique DATE
);

-- ============================================================

--   Table : LIVRAISON                                            

-- ============================================================

CREATE TABLE Livraisons (
    Reference VARCHAR(20) PRIMARY KEY,
    Date_livraison DATE,
    Qualite_livraison VARCHAR(50)
    Immatriculation INT NOT NULL,
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

--   Table : DEPÔT                                            

-- ============================================================
CREATE TABLE Depot (
    Numero_depot VARCHAR(20) PRIMARY KEY,
    Nom_depot VARCHAR(50),
    Ville VARCHAR(50)
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
    Numero_depot VARCHAR(20),
    Code_produit VARCHAR(20),
    Quantite_stockee INT,
    PRIMARY KEY (Numero_depot, Code_produit),
    FOREIGN KEY (Numero_depot) REFERENCES Depot(Numero_depot),
    FOREIGN KEY (Code_produit) REFERENCES Produit(Code_produit)
);

-- ============================================================

--   Table : not needded                                            

-- ============================================================
/*CREATE TABLE Transporter (
    Immatriculation VARCHAR(20),
    Reference VARCHAR(20),
    PRIMARY KEY (Immatriculation, Reference),
    FOREIGN KEY (Immatriculation) REFERENCES Camion(Immatriculation),
    FOREIGN KEY (Reference) REFERENCES Livraison(Reference)
);*/

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

--   Table :                                             
--not needed
-- ============================================================
/*CREATE TABLE Recevoir (
    Numero_depot VARCHAR(20),
    Reference VARCHAR(20),
    PRIMARY KEY (Numero_depot, Reference),
    FOREIGN KEY (Numero_depot) REFERENCES Depot(Numero_depot),
    FOREIGN KEY (Reference) REFERENCES Livraison(Reference)
);*/

-- ============================================================
--   Table :                                             
--not needed
-- ============================================================
/*CREATE TABLE Livrer (
    Reference VARCHAR(20),
    Code_produit VARCHAR(20),
    Quantite_livree INT,
    PRIMARY KEY (Reference, Code_produit),
    FOREIGN KEY (Reference) REFERENCES Livraison(Reference),
    FOREIGN KEY (Code_produit) REFERENCES Produit(Code_produit)
);*/
-- ============================================================

--   Table : MANAGE (Un admin manage les chaufeur)                                            

-- ============================================================
CREATE TABLE Manager {
    Identifiant_admin INT,
    Identifiant_chauffeur INT,
    PRIMARY KEY (Identifiant_admin, Identifiant_chauffeur),
    FOREIGN KEY (Identifiant_chauffeur) REFERENCES Chauffeur(Identifiant),
    FOREIGN KEY (Identifiant_admin) REFERENCES Admin(Identifiant)
    /*FOREIGN KEY (Identifiant_admin, Identifiant_chauffeur)*/
};
-- ============================================================

--   Table : GERER (Un admin gère les livraisons)                                            

-- ============================================================
CREATE TABLE Gerer {
    Identifiant INT, 
    Reference VARCHAR(20),
    PRIMARY KEY (Identifiant, Reference),
    -- FOREIGN KEY (Identifiant, Reference) doesn't provide a reference to a table
    FOREIGN KEY (Identifiant) REFERENCES Admin(Identifiant),
    FOREIGN KEY (Reference) REFERENCES Livraisons(Reference)
};
-- ============================================================

--   Table : CONTENIR (Une livraison contient des produits)                                            

-- ============================================================
CREATE TABLE Contenir {
    Reference VARCHAR(20),
    Code_produit VARCHAR(20),
    Quantite_livree INT,
    PRIMARY KEY (Reference, Code_produit),
    FOREIGN KEY (Reference) REFERENCES Livraisons(Reference),
    FOREIGN KEY (Code_produit) REFERENCES produits(Code_produit)
    -- FOREIGN KEY (Reference, Code_produit) doesn't provide a reference to a table
};
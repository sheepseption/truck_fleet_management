-- ============================================================

--   Nom de la base   :  LOGISTIQUES                                

--   Nom de SGBD      :  PostgreSQL                   

--   Date de creation :  26/10/2024                       

-- ============================================================

-- ============================================================
-- ============================================================

--                        TABLES

-- ============================================================
-- ============================================================


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
CREATE TYPE état AS ENUM ('Disponible', 'En Maintenance', 'En Panne');

CREATE TABLE Camion (
    Immatriculation VARCHAR(20) PRIMARY KEY,
    Date_mise_en_service DATE,
    Date_achat DATE,
    Kilometrage INT,
    Etat état,
    Kilometrage_vidange INT,
    Date_controle_technique DATE,
    Localisation VARCHAR(50),
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

CREATE TYPE qualité AS ENUM ('Terrible', 'Mauvaise' ,'Moyenne', 'Bonne', 'Excellent');

CREATE TABLE Livraison (
    Reference VARCHAR(20) PRIMARY KEY,
    Date_livraison DATE,
    Qualite_livraison qualité,
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
    Date TIMESTAMP,
    PRIMARY KEY (Identifiant, Type),
    FOREIGN KEY (Identifiant) REFERENCES Chauffeur(Identifiant),
    FOREIGN KEY (Type) REFERENCES Infraction(Type)
);

-- ============================================================
--   Table : MANAGER (Un admin manage les chaufeur)                                            
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
    FOREIGN KEY (DepotB) REFERENCES Depot(Numero_depot)  
);



-- ============================================================
--   Table : PARKING                                          
-- ============================================================
CREATE TABLE Parking (
    Depot INT,
    Immatriculation VARCHAR(20),
    Date_Commencement DATE,
    Date_Fin DATE,
    PRIMARY KEY (Depot, Immatriculation, Date_Commencement),
    FOREIGN KEY (Depot) REFERENCES Depot(Numero_depot),
    FOREIGN KEY (Immatriculation) REFERENCES Camion(Immatriculation)
);

-- ============================================================
-- ============================================================

--                        CONSTRAINTS

-- ============================================================
-- ============================================================

-- ============================================================
--   Contrainte : Personnel
-- ============================================================
ALTER TABLE Personnel
ADD CONSTRAINT Personnel_Anciennete CHECK (Anciennete >= 0),
Add CONSTRAINT Personnel_Absence CHECK (Absence >= 0);

-- ============================================================
--   Contrainte : Chauffeur
-- ============================================================
ALTER TABLE Chauffeur
ADD CONSTRAINT Chauffeur_Type_permis CHECK (Type_permis IN ('A', 'B', 'C', 'D', 'E'));

-- ============================================================
--   Contrainte : Camion
-- ============================================================
ALTER TABLE Camion
ADD CONSTRAINT Camion_Kilometrage CHECK (Kilometrage >= 0),
Add CONSTRAINT Camion_Kilometrage_vidange CHECK (Kilometrage_vidange >= 0),
Add CONSTRAINT Camion_Date_controle_technique CHECK (Date_controle_technique >= Date_mise_en_service);

-- ============================================================
--   Contrainte : Livraison
-- ============================================================
ALTER TABLE Livraison
ADD CONSTRAINT Livraison_Date_livraison CHECK (Numero_depot_entrant != Numero_depot_sortant);

-- ============================================================
--   Contrainte : Produit
-- ============================================================
ALTER TABLE Produit
ADD CONSTRAINT Produit_Poids CHECK (Poids >= 0);

-- ============================================================
--   Contrainte : Stocker
-- ============================================================
ALTER TABLE Stocker
ADD CONSTRAINT Stocker_Quantite_stockee CHECK (Quantite_stockee >= 0);

-- ============================================================
--   Contrainte : Manager
-- ============================================================
ALTER TABLE Manager
ADD CONSTRAINT Manager_Identifiant_admin CHECK (Identifiant_admin >= 0),
Add CONSTRAINT Manager_Identifiant_chauffeur CHECK (Identifiant_chauffeur >= 0);

-- ============================================================
--   Contrainte : Gerer
-- ============================================================
ALTER TABLE Gerer
ADD CONSTRAINT Gerer_Identifiant CHECK (Identifiant >= 0);

-- ============================================================
--   Contrainte : Contenir
-- ============================================================
ALTER TABLE Contenir
ADD CONSTRAINT Contenir_Quantite_livree CHECK (Quantite_livree >= 0);

-- ============================================================
--   Contrainte : Distance
-- ============================================================
ALTER TABLE Distance
ADD CONSTRAINT Distance_Distance CHECK (Distance >= 0),
ADD CONSTRAINT DepotA_not_DepotB CHECK (DepotA != DepotB);

-- ============================================================
-- ============================================================

--                        TRIGGER

-- ============================================================
-- ============================================================

CREATE OR REPLACE FUNCTION update_kilometrage()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Camion 
    SET Kilometrage = Kilometrage + 
        (SELECT Distance FROM Distance 
         WHERE (DepotA = NEW.Numero_depot_sortant AND DepotB = NEW.Numero_depot_entrant)
         OR (DepotA = NEW.Numero_depot_entrant AND DepotB = NEW.Numero_depot_sortant))
    WHERE Immatriculation = NEW.Immatriculation;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_livraison_insert
AFTER INSERT ON Livraison
FOR EACH ROW
EXECUTE FUNCTION update_kilometrage();

CREATE OR REPLACE FUNCTION check_maintenance()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Kilometrage - NEW.Kilometrage_vidange >= 10000 THEN
        NEW.Etat = 'En Maintenance';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_camion_update
BEFORE UPDATE ON Camion
FOR EACH ROW
EXECUTE FUNCTION check_maintenance();

CREATE OR REPLACE FUNCTION update_stock()
RETURNS TRIGGER AS $$
BEGIN
    -- Réduire le stock dans le dépôt de départ
    UPDATE Stocker
    SET Quantite_stockee = Quantite_stockee - NEW.Quantite_livree
    WHERE Numero_depot = (SELECT Numero_depot_sortant FROM Livraison WHERE Reference = NEW.Reference)
    AND Code_produit = NEW.Code_produit;
    
    -- Augmenter le stock dans le dépôt cible
    UPDATE Stocker
    SET Quantite_stockee = Quantite_stockee + NEW.Quantite_livree
    WHERE Numero_depot = (SELECT Numero_depot_entrant FROM Livraison WHERE Reference = NEW.Reference)
    AND Code_produit = NEW.Code_produit;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_contenir_insert
AFTER INSERT ON Contenir
FOR EACH ROW
EXECUTE FUNCTION update_stock();

CREATE OR REPLACE FUNCTION check_chauffeur_disponible()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM Livraison 
        WHERE Identifiant = NEW.Identifiant 
        AND Date_livraison = NEW.Date_livraison
    ) THEN
        RAISE EXCEPTION 'Chauffeur déjà prévu pour cette journée';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_livraison_insert
BEFORE INSERT ON Livraison
FOR EACH ROW
EXECUTE FUNCTION check_chauffeur_disponible();

CREATE OR REPLACE FUNCTION check_stock_suffisant()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Quantite_livree > (
        SELECT Quantite_stockee 
        FROM Stocker 
        WHERE Numero_depot = (
            SELECT Numero_depot_sortant 
            FROM Livraison 
            WHERE Reference = NEW.Reference
        )
        AND Code_produit = NEW.Code_produit
    ) THEN
        RAISE EXCEPTION 'Stock insuffisant pour cette livraison';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_contenir_insert
BEFORE INSERT ON Contenir
FOR EACH ROW
EXECUTE FUNCTION check_stock_suffisant();

CREATE OR REPLACE FUNCTION set_parking()
RETURNS TRIGGER AS $$
BEGIN
    -- Définir Date_Fin pour l'entrée de parking précédente
    UPDATE Parking 
    SET Date_Fin = NEW.Date_livraison
    WHERE Immatriculation = NEW.Immatriculation 
    AND Date_Fin IS NULL;

    -- Ajoute une nouvelle entrée de parking
    INSERT INTO Parking (
        Depot, 
        Immatriculation, 
        Date_Commencement,
        Date_Fin
    )
    VALUES (
        NEW.Numero_depot_entrant, 
        NEW.Immatriculation, 
        NEW.Date_livraison,
        NULL
    )
    ON CONFLICT (Depot, Immatriculation, Date_Commencement) DO 
    UPDATE SET 
        Date_Commencement = NEW.Date_livraison,
        Date_Fin = NULL;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_livraison_insert_parking
AFTER INSERT ON Livraison
FOR EACH ROW
EXECUTE FUNCTION set_parking();

CREATE OR REPLACE FUNCTION set_parking_date_fin()
RETURNS TRIGGER AS $$
BEGIN
    -- Setze Date_Fin für den offenen Parking-Eintrag des Fahrzeugs
    UPDATE Parking 
    SET Date_Fin = NEW.Date_livraison
    WHERE Immatriculation = NEW.Immatriculation 
    AND Date_Fin IS NULL 
    AND Date_Commencement < NEW.Date_livraison;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_livraison_insert_parking_date_fin
BEFORE INSERT ON Livraison
FOR EACH ROW
EXECUTE FUNCTION set_parking_date_fin();
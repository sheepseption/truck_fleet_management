-- ============================================================
--   Table : CAMION                                            
-- ============================================================

-- Mettre le véhicule en maintenance
UPDATE Camion
SET Etat = 'En Maintenance',
    Kilometrage_vidange = Kilometrage
WHERE Immatriculation = 'ABC123';

-- Marquer le véhicule comme disponible
UPDATE Camion
SET Etat = 'Disponible'
WHERE Immatriculation = 'ABC123';

-- ============================================================
--   Table : Personnel
-- ============================================================

-- Mettre à jour l'absence
UPDATE Personnel
SET Absence = Absence + 1
WHERE Identifiant = 2;

-- ============================================================
--   Table : Stocker
-- ============================================================

-- Correction manuelle des stocks
UPDATE Stocker
SET Quantite_stockee = Quantite_stockee + 100
WHERE Numero_depot = 1 
AND Code_produit = 'PROD123';

-- ============================================================
--   Table : Livraison
-- ============================================================

-- Évaluation de la qualité d'une livraison
UPDATE Livraison
SET Qualite = 'Bonne'
WHERE Reference = 'LIV123';

-- Changer le statut de la livraison
UPDATE Livraison
SET Date_fin = CURRENT_TIMESTAMP
WHERE Reference = 'LIV123';
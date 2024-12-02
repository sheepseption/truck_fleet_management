-- ============================================================
--   DROP TABLES                                            
-- ============================================================

DROP TABLE IF EXISTS Commettre;
DROP TABLE IF EXISTS Stocker;
DROP TABLE IF EXISTS Admin CASCADE;
DROP TABLE IF EXISTS Chauffeur CASCADE;
DROP TABLE IF EXISTS Infraction; 
DROP TABLE IF EXISTS Depot CASCADE;
DROP TABLE IF EXISTS Produit CASCADE;
DROP TABLE IF EXISTS Livraison CASCADE;
DROP TABLE IF EXISTS Camion CASCADE;
DROP TABLE IF EXISTS Personnel CASCADE;
DROP TABLE IF EXISTS Modele;
DROP TABLE IF EXISTS Manager;
DROP TABLE IF EXISTS Gerer;
DROP TABLE IF EXISTS Contenir;
DROP TABLE IF EXISTS Distance;
DROP TABLE IF EXISTS Parking CASCADE;

-- ============================================================
--   DROP TYPES                                            
-- ============================================================
DROP TYPE IF EXISTS qualité;
DROP TYPE IF EXISTS état;
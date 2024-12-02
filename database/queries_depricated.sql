-- here we define queries

/* 1- REQUETE CONSULTATION */

--------------- MANIPULATION CHAUFFEUR ------------------



-- récuperer le chauffeur d'une certaine ville:
select Nom, Prenom
from Personnel natural join Chauffeur
where Ville_personnel = 'Ville A'

delimiter $$
create procedure FromCity(city VARCHAR(50))
begin
    select Nom, Prenom
        from Personnel natural join Chauffeur
        where Ville = city;


end$$
delimiter ;

-- récuperer les données d'un chauffeur x:
select *
from Personnel natural join Chauffeur
where Nom = 'Jilali';

delimiter $$
create function DataChauf(NomChauffeur VARCHAR(50))
returns 
begin
    select *
        from Personnel natural join Chauffeur
        where Nom = NomChauffeur;


end$$
delimiter ;


-- 3 versions pour récuperer l'ancienneté:
select Anciennete
from Personnel natural join Chauffeur;


select Nom, Prenom, Anciennete
from Personnel natural join Chauffeur;


select Anciennete
from Personnel natural join Chauffeur
where Nom = 'Charles' and Prenom = 'Darwin';

delimiter $$
create function Anciennete(NomChauffeur VARCHAR(50), PrenomChauff VARCHAR(50))
returns INT
begin
    declare anciennete INT;
    select Anciennete
    into anciennete
    from Personnel natural join Chauffeur
    where Nom = NomChauffeur and Prenom = PrenomChauff;
    return anciennete;
    


end$$
delimiter ;


-- afficher les performances: Ici il y'a tout requête aidant à tirer les informations sur les performances.
/* retourne le type d'infraction */
select Type as "type infraction"
from Chauffeur natural join Commettre
where Nom = 'Hajja' and Prenom = 'El Hamdaouia';

delimiter $$
create function InfractionType(NomChauffeur VARCHAR(50), PrenomChauff VARCHAR(50))
returns VARCHAR(50)
begin
    declare InfType VARCHAR(50);
    select Type
    into InfType
    from Chauffeur natural join Commettre
    where Nom = NomChauffeur and Prenom = PrenomChauff;
    return InfType;
    


end$$
delimiter ;


/* retourne le nombre de livraisons faites */
select count(*)
from (Chauffeur natural join Livraison)
where Nom = 'Hajja' and Prenom = 'El Hamdaouia';
 

delimiter $$
create function NoDeliveries(NomChauffeur VARCHAR(50), PrenomChauff VARCHAR(50))
returns INT
begin
    declare NombreLivraison INT;
    select count(*)
    into NombreLivraison
    from Chauffeur natural join Livraison
    where Nom = NomChauffeur and Prenom = PrenomChauff;
    return NombreLivraison;
    


end$$
delimiter ;

/* retourne le nombre d'infractions commises */
select count(*)
from (Chauffeur natural join Commettre)
where Nom = 'Hajja' and Prenom = 'El Hamdaouia';


delimiter $$
create function NoInfractions(NomChauffeur VARCHAR(50), PrenomChauff VARCHAR(50))
returns INT
begin
    declare NombreInfraction INT;
    select count(*)
    into NombreLivraison
    from Chauffeur natural join Commettre
    where Nom = NomChauffeur and Prenom = PrenomChauff;
    return NombreLivraison;
    


end$$
delimiter ;

/* retourne la liste des qualités de livraison d'un chauffeur */
select Qualite_livraison
from (Chauffeur left outer join Livraison using(Identifiant))
where Nom = 'Hajja' and Prenom = 'El Hamdaouia';


delimiter $$
create procedure ListeQualite(NomChauff VARCHAR(50), PrenomChauff VARCHAR(50))
begin
    select Qualite_livraison
    from (Chauffeur left outer join Livraison using(Identifiant))
    where Nom = 'Hajja' and Prenom = 'El Hamdaouia';


end$$
delimiter ;

/* retourne le score de livraison */
select sum(
    case
        when Qualite_livraison = 'retard' then -1
        when Qualite_livraison = 'moyenne' then 2
        when Qualite_livraison = 'excellente' then 4
        else 0
    end
) as score_livraison
from Chauffeur left outer join Livraison using(Identifiant)
where Nom = 'Friedrich' and Prenom = 'Nietzsche';


delimiter $$
create function DelyScore(NomChauff VARCHAR(50), PrenomChauff VARCHAR(50))
returns INT
begin
    declare delyScore INT;
    select sum(
    case
        when Qualite_livraison = 'retard' then -1
        when Qualite_livraison = 'moyenne' then 2
        when Qualite_livraison = 'excellente' then 4
        else 0
    end)
    into delyScore
    from Chauffeur left outer join Livraison using(Identifiant)
    where Nom = NomChauff and Prenom = PrenomChauff;
    return delyScore;
end$$
delimiter ;

/* retourne le score d'infraction */
select sum(
    case
        when Type = 'vitesse' then -1
        when Type = 'feu rouge' then -2
        when Type = 'provoquer accident' then -3
        when Type = 'tuer un chat' then -666
        else 0
    end
) as score_infraction
from Chauffeur left outer join Commettre using(Identifiant)
where Nom = 'CHeikha' and Prenom = 'Rimitti';


delimiter $$
create function InfScore(NomChauff VARCHAR(50), PrenomChauff VARCHAR(50))
returns INT
begin
    declare infScore INT;
    select sum(
    case
        when Type = 'vitesse' then -1
        when Type = 'feu rouge' then -2
        when Type = 'provoquer accident' then -3
        when Type = 'tuer un chat' then -666
        else 0
    end)
    into infScore
    from Chauffeur left outer join Commettre using(Identifiant)
    where Nom = NomChauff and Prenom = PrenomChauff;
    return infScore;
end$$
delimiter ;

/* une version finale >> la performance d'un chauffeur/un peu bizarre mais intéressante */
create function performance(NomChauff VARCHAR(50), PrenomChauff VARCHAR(50))
returns INT
begin
    declare performance INT;
    with livraison as(
        select sum(
            case
                when Qualite_livraison = 'retard' then -1
                when Qualite_livraison = 'moyenne' then 2
                when Qualite_livraison = 'excellente' then 4
                else 0
            end
        ) as score_livraison
        from Chauffeur left outer join Livraison using(Identifiant)
        where Nom = NomChauff and Prenom = PrenomChauff
    ),
    absence as(
        select Absence
        from Chauffeur natural join Personnel
        where Nom = NomChauff and Prenom = PrenomChauff
    ),
    infraction as(
        select sum(
            case
                when Type = 'vitesse' then -1
                when Type = 'feu rouge' then -2
                when Type = 'provoquer accident' then -3
                when Type = 'tuer un chat' then -666
                else 0
            end
        ) as score_infraction
        from Chauffeur left outer join Commettre using(Identifiant)
        where Nom = NomChauff and Prenom = PrenomChauff
    )
    select livraison.score_livraison - absence.Absence + infraction.score_infraction
    into performance
    from livraison, absence, infraction;
    return performance;

end$$
delimiter ;


/* La table des performances */
select Identifiant, Nom, Prenom,
sum(
    case
        when Qualite_livraison = 'retard' then -1
        when Qualite_livraison = 'moyenne' then 2
        when Qualite_livraison = 'excellente' then 4
        else 0
    end
) -
sum(
    case
        when Type = 'vitesse' then -1
        when Type = 'feu rouge' then -2
        when Type = 'provoquer accident' then -3
        when Type = 'tuer un chat' then -666
        else 0
    end
) - Absence
from Chauffeur  left outer join Livraison using(Identifiant)
                left outer join Commettre using(Identifiant)
group by Identifiant;


delimiter $$
create procedure performanceTable()
begin
    select Identifiant, Nom, Prenom,
    sum(
        case
            when Qualite_livraison = 'retard' then -1
            when Qualite_livraison = 'moyenne' then 2
            when Qualite_livraison = 'excellente' then 4
            else 0
        end
    ) -
    sum(
        case
            when Type = 'vitesse' then -1
            when Type = 'feu rouge' then -2
            when Type = 'provoquer accident' then -3
            when Type = 'tuer un chat' then -666
            else 0
        end
    ) - Absence
    from Chauffeur  left outer join Livraison using(Identifiant)
                    left outer join Commettre using(Identifiant)
    group by Identifiant, Nom, Prenom;

end$$
delimiter ;


--------------- MANIPULATION CAMION ------------------


-- récuperer kilométrage camion:
select Immatriculation, Kilometrage 
from Camion;

select Kilometrage
from Camion
where Immatriculation = 'AXV-12698-POS';


delimiter $$
create function Kilometers(Palette VARCHAR(50))
returns DECIMAL(10,2)
begin
    declare km DECIMAL(10,2);
    select Kilometrage
    into km
    from Camion
    where Immatriculation = Palette;
    return km;


end$$
delimiter ;

-- récuperer kilométrage après vidange:
select Immatriculation, Kilometrage_vidange
from Camion;

select Kilometrage_vidange
from Camion
where Immatriculation = 'AXV-12698-POS';

delimiter $$
create function KiloVidange(Palette VARCHAR(50))
returns DECIMAL(10,2)
begin
    declare kmVid DECIMAL(10,2);
    select Kilometrage_vidange
    into kmVid
    from Camion
    where Immatriculation = Palette;
    return kmVid;


end$$
delimiter ;

-- récuperer les camions ayant besoin d'un vidange:
select Immatriculation
from Camion
where Kilometrage_vidange > 16000;


delimiter $$
create procedure NeedVidange()

begin
    select Immatriculation
    from Camion
    where Kilometrage_vidange > 16000;

end$$
delimiter ;

-- récuperer les dates de contrôles techniques des camions:
select Immatriculation, Date_controle_technique
from Camion;

select Date_controle_technique
from Camion
where Immatriculation = 'AXV-12698-POS';


delimiter $$
create function techControleDate(Palette VARCHAR(50))
returns DATE
begin
    declare controlDate DATE;
    select Date_controle_technique
    into controlDate
    from Camion
    where Immatriculation = Palette;
    return controlDate;


end$$
delimiter ;

-- récuperer les camions ayant besoin du contrôle technique:
select Immatriculation
from camion
where DATE(NOW()) - Date_controle_technique > 365;


delimiter $$
create procedure NeedControl()
begin
    select Immatriculation
    from camion
    where DATE(NOW()) - Date_controle_technique > 365;  

end$$
delimiter ;

/* Dans cette partie, penser après à faire le "set" du kilométrage de vidange à 0. 
>> Dans ce qui suit, on considère que le fait de chercher les camions ayant besoin
du vidange joue le rôle d'un vidange (on fait confiance à l'admin =) 

Le vidange :
update Camion 
    set Kilometrage_vidange = 0
    where Kilometrage_vidange > 16000;
*/









--------------- MANIPULATION LIVRAISON ------------------

-- récuperer les livraisons d'une date donnée:
select Reference
from Livraison;

select Reference
from Livraison
where Date_livraison = '1956-01-11';


delimiter $$
create procedure LivraisonDuJour(jour DATE)
begin
    select Reference
    from Livraison
    where Date_livraison = jour;
end$$
delimiter ;

-- récuperer les livraisons entrantes/sortantes d'un dépôt:
select Reference
from Livraison
where Numero_depot_entrant = 666 and Numero_depot_sortant = 333;

delimiter $$
create procedure LivraisonES(depotE INT, depotS INT)
begin
    select Reference
    from Livraison
    where Numero_depot_entrant = depotE and Numero_depot_sortant = depotS;
end$$
delimiter ;

select Reference
from Livraison
where Numero_depot_entrant = 69;

delimiter $$
create procedure LivraisonE(depotE INT)
begin
    select Reference
    from Livraison
    where Numero_depot_entrant = depotE;
end$$
delimiter ;


select Reference
from Livraison
where Numero_depot_sortant = 7;

delimiter $$
create procedure LivraisonS(depotS INT)
begin
    select Reference
    from Livraison
    where Numero_depot_sortant = depotS;
end$$
delimiter ;

-- récuperer les livraisons d'une période donnée:
select Reference
from Livraison
where Date_livraison between '2024-11-30' and '2024-12-31';

delimiter $$
create procedure LivraisonDuJour(jourB DATE, jourE DATE)
begin
    select Reference
    from Livraison
    where Date_livraison between jourE and jourE;
end$$
delimiter ;

-- récuperer les produits d'une livraison:
select Code_produit, Nom_produit, Quantite_livree
from Contenir natural join Produit
where Reference = 255;

delimiter $$
create procedure LivProduits(delyRef VARCHAR(20))
begin
    select Code_produit, Nom_produit, Quantite_livree
    from Contenir natural join Produit
    where Reference = delyRef;
end$$
delimiter ;

-- récuperer les chauffeurs/camions d'une livraison:
select Nom, Prenom, Immatriculation
from (Chauffeur natural join Livraison) natural join Camion
where Reference = 255;

delimiter $$
create procedure LivChauffCam(delyRef VARCHAR(20))
begin
    select Nom, Prenom, Immatriculation
    from (Chauffeur natural join Livraison) natural join Camion
    where Reference = delyRef;
end$$
delimiter ;

-- récuperer le poids d'une livraison:
select sum(Poids)
from Contenir natural join Produit
where Reference = 255;

delimiter $$
create function delyWeight(delyRef VARCHAR(20))
returns DECIMAL(10,2)
begin
    declare delyW DECIMAL(10,2);
    select sum(Poids)
    into delyW
    from Contenir natural join Produit
    where Reference = delyRef;
end$$
delimiter ;

-- récuperer la qualité de livraison pour une certaine livraison:
select Qualite_livraison
from Livraison;







--------------- MANIPULATION DEPOT ------------------


-- récuperer les produits d'un dépôt avec leurs quantités:
select Code_produit, Quantite_stockee
from Stocker
where Numero_depot = 69;

delimiter $$
create procedure DepotStock(NummDepot INT)
begin
    select Code_produit, Quantite_stockee
    from Stocker
    where Numero_depot = NummDepot;
end$$
delimiter ;



/* 2- REQUETE STATISTIQUES */

--------------- MANIPULATION CHAUFFEUR ------------------

-- classer les chauffeurs selon l'ancieneté/rendement(nombre de livraison)/performance(absence, infraction).

select Nom, Prenom, Absence
from Chauffeur natural join Personnel
order by Absence asc;

select Identifiant, Nom, Prenom, count(*) as "Nombre_de_Livraison"
from Chauffeur natural join Livraison
group by Identifiant;
order by Nombre_de_livraisons desc;

/*copiée de la partie consultation */
select Identifiant, Nom, Prenom,
sum(
    case
        when Qualite_livraison = 'retard' then -1
        when Qualite_livraison = 'moyenne' then 2
        when Qualite_livraison = 'excellente' then 4
        else 0
    end
) -
select sum(
    case
        when Type = 'vitesse' then -1
        when Type = 'feu rouge' then -2
        when Type = 'provoquer accident' then -3
        when Type = 'tuer un chat' then -666
        else 0
    end
) - Absence as "performance"
from Chauffeur  left outer join Livraison using(Identifiant)
                left outer join Commettre using(Identifiant)
group by Identifiant
order by performance desc;


-- classer les camions vides proches d'un dépôt sortant:
  -- camion vide: la date de sa dernière livraison est avant la date d'aujourd'hui
  -- camion proche de D: la ville de son dépôt entrant de sa dernière livraison est la ville du dépôt sortant de la livraison en question.

/*n'est pas finie*/
/*select Immatriculation
from Camion left outer join Livraison using(Immatriculation)
where (select Date_livraison
       from Livraison natural join Camion
       group by Immatriculation);*/



--------------- MANIPULATION CAMION ------------------

-- afficher la moyenne des poids qu'un camion transporte: 
select Immatriculation, avg(Poids_Livraison)
from Camion join (select Reference,sum(Quantite_livree*Poids) as "Poids_livraison"
                    from (Livraison inner join Contenir using(Reference)) inner join Produit using(Code_produit)
                    group by Reference;) using(Immatriculation)
group by Immatriculation;

delimiter $$
create function GetAvgWeight(Palette VARCHAR(20))
returns DECIMAL(10,2)
begin
    declare avgPoids DECIMAL(10,2);
    select avg(Poids_Livraison)
    into avgPoids
    from(select Reference,sum(Quantite_livree*Poids) as "Poids_livraison"
                    from (Livraison inner join Contenir using(Reference)) inner join Produit using(Code_produit)
                    where Immatriculation = Palette 
                    group by Reference);
    return avgPoids;


end$$
delimiter ;

-- classer les camions selon la moyenne des poids: à faire.

select Immatriculation, avg(Poids_Livraison) as "Avg_poids"
from Camion join (select Reference,sum(Quantite_livree*Poids) as "Poids_livraison"
                    from (Livraison inner join Contenir using(Reference)) inner join Produit using(Code_produit)
                    group by Reference;) using(Immatriculation)
group by Immatriculation
order by Avg_poids desc;


delimiter $$
create procedure AvgChauffList()
begin
    select Immatriculation, avg(Poids_Livraison) as "Avg_poids"
    from Camion join (select Reference,sum(Quantite_livree*Poids) as "Poids_livraison"
                        from (Livraison inner join Contenir using(Reference)) inner join Produit using(Code_produit)
                        group by Reference;) using(Immatriculation)
    group by Immatriculation
    order by Avg_poids desc;

end$$
delimiter ;



/* 3- REQUETE MISE A JOUR */
-- A faire: Ajout, suppression, modification d’un camion, d’un chauffeur, d’un dépôt.



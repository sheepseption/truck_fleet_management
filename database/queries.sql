-- here we define queries

/* 1- REQUETE CONSULTATION */

--------------- MANIPULATION CHAUFFEUR ------------------



-- récuperer le chauffeur d'une certaine ville:
select Nom, Prenom
from Personnel natural join Chauffeur
where Ville = 'Atlantis';


-- récuperer les données d'un chauffeur x:
select *
from Personnel natural join Chauffeur
where Nom = 'Jilali';


-- 3 versions pour récuperer l'ancienneté:
select Anciennete
from Personnel natural join Chauffeur;


select Nom, Prenom, Anciennete
from Personnel natural join Chauffeur;


select Anciennete
from Personnel natural join Chauffeur
where Nom = 'Charles' and Prenom = 'Darwin';


-- afficher les performances: Ici il y'a tout requête aidant à tirer les informations sur les performances.
/* retourne le type d'infraction */
select Type as "type infraction"
from Chauffeur natural join Commettre
where Nom = 'Hajja' and Prenom = 'El Hamdaouia';

/* retourne le nombre de livraisons faites */
select count(*)
from (Chauffeur natural join Livraison)
where Nom = 'Hajja' and Prenom = 'El Hamdaouia';
 
/* retourne le nombre d'infractions commises */
select count(*)
from (Chauffeur natural join Commettre)
where Nom = 'Hajja' and Prenom = 'El Hamdaouia';

/* retourne la liste des qualités de livraison d'un chauffeur */
select Qualite_livraison
from (Chauffeur left outer join Livraison using(Identifiant))
where Nom = 'Hajja' and Prenom = 'El Hamdaouia';

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

/* une version finale >> la performance d'un chauffeur/un peu bizarre mais intéressante */
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
    where Nom = 'Friedrich' and Prenom = 'Nietzsche'
),
absence as(
    select Absence
    from Chauffeur natural join Personnel
    where Nom = 'Friedrich' and Prenom = 'Nietzsche'
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
    where Nom = 'CHeikha' and Prenom = 'Rimitti'
)
select livraison.score_livraison - absence.Absence - infraction.score_infraction
from livraison, absence, infraction;


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
select sum(
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








--------------- MANIPULATION CAMION ------------------


-- récuperer kilométrage camion:
select Immatriculation, Kilometrage 
from Camion;

select Kilometrage
from Camion
where Immatriculation = 'AXV-12698-POS';


-- récuperer kilométrage après vidange:
select Immatriculation, Kilometrage_vidange
from Camion;

select Kilometrage_vidange
from Camion
where Immatriculation = 'AXV-12698-POS';


-- récuperer les camions ayant besoin d'un vidange:
select Immatriculation
from Camion
where Kilometrage_vidange > 16000;


-- récuperer les dates de contrôles techniques des camions:
select Immatriculation, Date_controle_technique
from Camion;

select Date_controle_technique
from Camion
where Immatriculation = 'AXV-12698-POS';


-- récuperer les camions ayant besoin du contrôle technique:
select Immatriculation
from camion
where DATE(NOW()) - Date_controle_technique > 365;

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


-- récuperer les livraisons entrantes/sortantes d'un dépôt:
select Reference
from Livraison
where Numero_depot_entrant = 666 and Numero_depot_sortant = 333;

select Reference
from Livraison
where Numero_depot_entrant = 69;

select Reference
from Livraison
where Numero_depot_sortant = 7;


-- récuperer les livraisons d'une période donnée:
select Reference
from Livraison
where Date_livraison between '2024-11-30' and '2024-12-31';


-- récuperer les produits d'une livraison:
select Code_produit, Nom_produit, Quantite_livree
from Contenir natural join Produit
where Reference = 255;


-- récuperer les chauffeurs/camions d'une livraison:
select Nom, Prenom, Immatriculation
from (Chauffeur natural join Livraison) natural join Camion
where Reference = 255;


-- récuperer le poids d'une livraison:
select sum(Poids)
from Contenir natural join Produit
where Reference = 255;

-- récuperer la qualité de livraison pour une certaine livraison:
select Qualite_livraison
from Livraison;







--------------- MANIPULATION DEPOT ------------------


-- récuperer les produits d'un dépôt avec leurs quantités:
select Code_produit, Quantite_stockee
from Stocker
where Numero_depot = 69;





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

-- afficher la moyenne des poids qu'un camion transporte: n'est pas finie
/*select avg(select sum(Poids)
           from Contenir natural join Produit
           where Reference = 255;)
from (Camion left outer join Livraison using(Identifiant)) natural join Produit

*/

-- classer les camions selon la moyenne des poids: à faire.








/* 3- REQUETE MISE A JOUR */
-- A faire: Ajout, suppression, modification d’un camion, d’un chauffeur, d’un dépôt.



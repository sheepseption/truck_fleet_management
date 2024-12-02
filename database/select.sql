-- moyenne des poids transportés par camion par livraison,
SELECT
    reference,
    ROUND(sum(poid_produit_totale) / sum(quantite_livree), 4) as poid_moyenne
FROM
    (
        SELECT
            reference,
            quantite_livree,
            Quantite_livree * Poids as poid_produit_totale
        from
            (
                Livraison
                inner join Contenir using (Reference)
            )
            inner join Produit using (Code_produit)
    )
Group by
    reference
    -- moyenne des distances parcourues par les chauffeurs pour effectuer une livraison,
SELECT
    identifiant as ID_Chauffeur,
    ROUND(avg(distance), 2) as moyenne_distance
FROM
    Livraison l
    JOIN Distance D ON (l.Numero_depot_entrant = d.DepotA)
    or (l.Numero_depot_entrant = d.DepotB)
Group By
    identifiant
    -- classement des chauffeurs,
SELECT
    ID_Chauffeur,
    nom,
    prenom,
    absence,
    nombre_livraison,
    ROUND(moyenne_distance, 4) as moyenne_distance,
    distance_totale,
    nombre_infraction
FROM
    (
        SELECT
            cp.identifiant as ID_Chauffeur,
            cp.nom,
            cp.prenom,
            cp.absence,
            nombre_livraison,
            moyenne_distance,
            distance_totale
        From
            (
                SELECT
                    c.identifiant,
                    p.nom,
                    p.prenom,
                    p.absence
                FROM
                    Chauffeur as c
                    left join personnel as p On (c.identifiant = p.identifiant)
            ) as cp
            left join (
                SELECT
                    identifiant as identifiant,
                    count(reference) as nombre_livraison,
                    avg(distance) as moyenne_distance,
                    sum(distance) as distance_totale
                FROM
                    Livraison l
                    JOIN Distance D ON (l.Numero_depot_entrant = d.DepotA)
                    or (l.Numero_depot_entrant = d.DepotB)
                Group By
                    identifiant
            ) as ld on ld.identifiant = cp.identifiant
    ) as ldcp
    left Join (
        SELECT
            identifiant,
            count(type) as nombre_infraction
        FROM
            Commettre
        Group By
            identifiant
    ) as ci on ci.identifiant = ldcp.ID_Chauffeur
    -- classement des dépôts les plus proches d'une destination,
WITH RankedDistances AS (
    SELECT
        d1.Numero_depot AS DepotA,
        d2.Numero_depot AS DepotB,
        dist.Distance,
        ROW_NUMBER() OVER (PARTITION BY d1.Numero_depot ORDER BY dist.Distance ASC) AS rank
    FROM
        Depot d1
    JOIN
        Distance dist ON d1.Numero_depot = dist.DepotA
    JOIN
        Depot d2 ON dist.DepotB = d2.Numero_depot
)
SELECT
    DepotA as Depot,
    DepotB as Top3NearestDepots,
    Distance
FROM
    RankedDistances
WHERE
    rank <= 3
ORDER BY
    DepotA,
    Distance;


    -- classement des camions vides les plus proches d'un dépôt.
WITH CurrentParking AS (
    SELECT DISTINCT ON (Immatriculation) 
        Immatriculation, 
        Depot,
        Date_Commencement
    FROM Parking
    WHERE Date_Fin IS NULL
    ORDER BY Immatriculation, Date_Commencement DESC
),
AllPossibleDestinations AS (
    SELECT 
        c.Immatriculation,
        0 as distance_to_depot, 
        cp.Depot as current_depot,
        cp.Depot as target_depot,
        m.Marque
    FROM Camion c
    JOIN Modele m ON c.Numero_modele = m.Numero_modele
    JOIN CurrentParking cp ON c.Immatriculation = cp.Immatriculation
    WHERE c.Etat = 'Disponible'
    
    UNION ALL

    SELECT 
        c.Immatriculation,
        d.Distance as distance_to_depot,
        cp.Depot as current_depot,
        d.DepotB as target_depot,
        m.Marque
    FROM Camion c
    JOIN Modele m ON c.Numero_modele = m.Numero_modele
    JOIN CurrentParking cp ON c.Immatriculation = cp.Immatriculation
    JOIN Distance d ON cp.Depot = d.DepotA
    WHERE c.Etat = 'Disponible'
),
RankedTrucks AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY target_depot ORDER BY 
            CASE 
                WHEN current_depot = target_depot THEN 0 
                ELSE distance_to_depot 
            END
        ) as rank
    FROM AllPossibleDestinations
    WHERE NOT EXISTS (
        SELECT 1 
        FROM Livraison l 
        WHERE l.Immatriculation = AllPossibleDestinations.Immatriculation 
        AND l.Date_livraison = CURRENT_DATE
    )
)
SELECT 
    target_depot as Depot_Cible,
    Immatriculation,
    Marque,
    distance_to_depot as Distance,
    current_depot as Depot_Actuel
FROM RankedTrucks
WHERE rank <= 3
ORDER BY target_depot, distance_to_depot;
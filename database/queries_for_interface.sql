-- extraire les produits et leurs quantité dans un dépot: ici il faut faire une formule qui calcule le poids max selon les numéros écrites par l'utilisateur:

select Code_produit, Quantite_livree, Poids
from Contenir natural join Produit
Where Reference = x;




-- Camions proche et dispo: again, ici localisation est ce que l'admin écrit:
select Immatriculation
from Camion 
where Localisation = x and Etat = "disponible";



-- Capacité camion convenable: ici P est le poids calculé à travers ce que l'admin chosi comme quantité:
-- P = SIGMA(Poids*quantité tapée).
select Immatriculation
from Camion
where Capacité >= P;



-- BIG TRIGGER HHH:
delimiter $$
create trigger update_after_delivery
after insert on Livraison
for each row
begin
    declare depot_entrant INT;
    declare depot_sortant INT;
    declare distance DECIMAL(10,2);
    declare quantite INT;
    declare code_prod VARCHAR(20);
    -- extraire la distance entre les deux dépôts:
    select Distance into distance
    from Distance
    where (DepotA = NEW.Numero_depot_entrant and DepotB = NEW.Numero_depot_sortant) 
        or (DepotA = NEW.Numero_depot_sortant and DepotB = NEW.Numero_depot_entrant);

    -- trigger sur le vidange:
    update Camion
    set Kilometrage_vidange = Kilometrage_vidange + distance
    where Immatriculation = NEW.Immatriculation;


    -- loop sur les produits de la livraison
    declare cur cursor for   
        select Code_produit, Quantite_livree
        from Contenir
        where Reference = NEW.Reference;

    declare continue handler for not found set done = true;

    open cur;
    loop_prod: loop
        fetch cur into code_prod, quantite;
        if done then 
            leave loop_prod;
        end if;


    -- trigger sur le stockage:
        update Stocker
        set Quantite_stockee = Quantite_stockee - quantite
        where Numero_depot = NEW.Numero_depot_sortant and Code_produit = code_prod;


        update Stocker
        set Quantite_stockee = Quantite_stockee + quantite
        where Numero_depot = NEW.Numero_depot_entrant and Code_produit = code_prod;
    
    end loop;
    close cur;
end$$
delimiter;
DELIMITER |

CREATE PROCEDURE facture(IN p_ord_id)

BEGIN 
-- INFORMATIONS CLIENT
(SELECT c.cus_id as 'client', c.cus_lastname as 'nom', c.cus_firstname as 'prénom', c.cus_address as 'adresse', c.cus_zipcode as 'code postal', c.cus_city as 'ville', c.cus_mail as 'email', c.cus_phone as 'téléphone'
FROM `orders` o
    JOIN `customers` c on c.cus_id = o.ord_cus_id
where o.ord_id=p_ord_id);

where o.ord_id=p_ord_id;
-- DETAILS COMMANDE
SELECT p.pro_ref as 'reference', p.pro_desc as 'description', ode.ode_unit_price as 'prix unitaire HT', ode.ode_quantity as 'quantité', ode_unit_price*ode_quantity as 'total ht', 0.2*ode_unit_price*ode_quantity as 'TVA', ode_unit_price*ode_quantity*(1-ode_discount/100)*1.2 as 'total TTC'
FROM `orders` o
    JOIN `orders_details` ode on o.ord_id = ode.ode_ord_id
    JOIN `products` p on p.pro_id = ode.ode_pro_id
where o.ord_id=p_ord_id;

-- INFORMATIONS COMMANDE
SELECT o.ord_id as "numéro de facture", o.ord_order_date as 'date de commande', o.ord_payment_date as 'date de payement', o.ord_ship_date "date d'envoi", o.ord_status as 'statut de la commande',
sum(ode.ode_unit_price*ode.ode_quantity) as 'total commande HT', sum(0.2*ode.ode_unit_price*ode.ode_quantity) as 'TVA', sum(ode.ode_unit_price*ode.ode_quantity*(1-ode.ode_discount/100)*1.2) as 'Total commande TTC'
FROM `orders` o
    JOIN `orders_details` ode on o.ord_id = ode.ode_ord_id
END |

DELIMITER ;
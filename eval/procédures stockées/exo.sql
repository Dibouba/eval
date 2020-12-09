DELIMITER  &&

DROP PROCEDURE IF EXISTS facture &&
CREATE PROCEDURE facture(IN p_ord_id int)
BEGIN
SELECT   ode_id AS 'Numéro Facture', ord_order_date AS 'Date facture', ord_payment_date AS 'Date paiement', ord_ship_date AS 'Date envoi', sho_name AS 'Vendeur', CONCAT(sho_address,' ',sho_zipcode,' ',sho_city) AS 'Adresse vendeur', 
concat(cus_lastname,' ',cus_firstname) AS 'Client', concat(cus_address,' ',cus_zipcode,' ',cus_city) AS 'Adresse Client', ord_id AS 'Bon Commande', pro_ref AS 'Libéllé', pro_name AS 'Designation',  ode_unit_price AS 'PU',   ode_quantity AS 'Quantité',
FROM customers
JOIN orders
on customers.cus_id = orders.ord_cus_id
join orders_details
on orders.ord_id = orders_details.ode_ord_id
JOIN products
on orders_details.ode_pro_id = products.pro_id
WHERE ord_id = p_ord_id;

SELECT
Round((ode_unit_price/100*20),1) AS 'TVA', ode_discount AS 'Remise',
SUM((ode_unit_price+ode_unit_price/100 * 20)-(ode_unit_price/100 * ode_discount)) AS 'PTTC'
FROM orders_details
WHERE ode_ord_id = p_ord_id;

END &&

DELIMITER ;





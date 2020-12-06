DELIMITER  &&

DROP PROCEDURE IF EXISTS facture &&
CREATE PROCEDURE facture(IN p_ord_id int)
BEGIN
SELECT
Round((ode_unit_price/100*20),1) AS 'TVA', ode_discount AS 'Remise',
SUM((ode_unit_price+ode_unit_price/100 * 20)-(ode_unit_price/100 * ode_discount)) AS 'PTTC'
FROM orders_details
WHERE ode_ord_id = p_ord_id;

END &&

DELIMITER ;

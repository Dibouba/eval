DELIMITER $$

CREATE TRIGGER after_products_update
AFTER UPDATE 
ON products FOR EACH ROW

BEGIN
    DECLARE pro_stock_alert INT;
    SET pro_stock_alert=5;
  IF (NEW.pro_stock <> old.pro_stock) and (NEW.pro_stock <= pro_stock_alert) THEN
    INSERT INTO commande_article (codart, qte, date_du_jour) 
      VALUES (OLD.pro_id, NEW.pro_stock, NOW());
  END IF;
  IF(NEW.pro_stock > pro_stock_alert)
     delete from 
     where codart = OLD.pro_id
END $$
 
DELIMITER ;
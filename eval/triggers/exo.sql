DELIMITER $$
DROP TRIGGER IF EXISTS AFTER_products_update $$
CREATE TRIGGER AFTER_products_update
AFTER UPDATE ON products FOR EACH row
BEGIN
    DECLARE pro_stock_alert INT;
    SET pro_stock_alert = 5;
      IF (NEW.pro_stock != OLD.pro_stock) AND (NEW.pro_stock <= pro_stock_alert) THEN
        INSERT INTO commander_articles (codart, qte, date_du_jour) 
        VALUES (OLD.pro_id, NEW.pro_stock, NOW());
      END IF;
    
    IF(NEW.pro_stock > pro_stock_alert) THEN
        DELETE FROM commander_articles WHERE codart IN (SELECT OLD.pro_id FROM products WHERE NEW.pro_stock>pro_stock_alert); 
    END IF;
END $$
DELIMITER ;
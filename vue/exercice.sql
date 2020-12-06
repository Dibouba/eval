CREATE VIEW v_catalogue_products
AS 
SELECT pro_id, cat_id, cat_name, pro_ref, pro_name
FROM products
JOIN categories
ON products.pro_cat_id = categories.cat_id
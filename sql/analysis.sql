-- Receita total
SELECT SUM(price) as Receita_Total FROM order_items;

-- Ticket médio
SELECT 
    AVG(valor_pedido) AS ticket_medio
FROM (
    SELECT 
        SUM(price) AS valor_pedido
    FROM order_items
    GROUP BY order_id
) t;

-- Receita total por categoria
SELECT p.product_category_name AS categoria,
	   SUM(oi.price) AS receita
FROM order_items oi
JOIN products p on oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY receita DESC;

-- Tempo médio de entrega
SELECT 
	AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS avg_deliver_time
    FROM orders
    WHERE order_delivered_customer_date IS NOT NULL;

-- Taxa de atraso
SELECT 
	count(*) AS total_entregue,
    SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) AS total_atrasos,
    SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) / COUNT(*) taxa_atraso
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;
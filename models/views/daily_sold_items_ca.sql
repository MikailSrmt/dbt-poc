{{ config(materialized='view') }}
select date_trunc('day', convert_timezone('gmt', 'pst', created_at)) date, sum(quantity) sold_items from shopify_ca.order_line p join shopify_ca.order o on o.id = p.order_id
group by date

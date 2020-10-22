{{ config(materialized='table') }}
select date_trunc('day', convert_timezone('gmt', 'pst', created_at)) date, (sum(subtotal_price)*0.76) sales from shopify_ca.order
group by date

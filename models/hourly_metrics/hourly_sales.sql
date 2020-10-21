{{ config(materialized='table') }}
select date_trunc('hour', convert_timezone('gmt', 'pst', created_at)) tr, sum(subtotal_price) from shopify.order
group by tr

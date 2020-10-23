{{ config(materialized='view') }}
select date_trunc('day', convert_timezone('gmt', 'pst', created_at)) date, sum(subtotal_price) sales from shopify.order
group by date

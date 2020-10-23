{{ config(materialized='table') }}

select s.date,
coalesce(sales, '0') as sales,
coalesce(sold_items, '0') as sold_items,
coalesce(facebook_spend, '0') facebook_spend,
coalesce(google_spend, '0') google_spend
from {{ref('stg_sales_with_sold_items_ca')}} s left outer join {{ref('stg_fb_spend_with_google_spend_ca')}} f on s.date=f.date

UNION

select f.date,
coalesce(sales, '0') as sales,
coalesce(sold_items, '0') as sold_items,
coalesce(facebook_spend, '0') facebook_spend,
coalesce(google_spend, '0') google_spend
from {{ref('stg_sales_with_sold_items_ca')}} s right outer join {{ref('stg_fb_spend_with_google_spend_ca')}} f on s.date=f.date

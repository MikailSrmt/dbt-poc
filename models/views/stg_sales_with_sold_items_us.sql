{{ config(materialized='view') }}
select sales.date, sales.sales, sold_items.sold_items
from {{ref('daily_sales_us')}} as sales left outer join {{ref('daily_sold_items_us')}} as sold_items on sales.date=sold_items.date

UNION

select sold_items.date, sales.sales, sold_items.sold_items
from {{ref('daily_sales_us')}} as sales right outer join {{ref('daily_sold_items_us')}} as sold_items on sales.date=sold_items.date

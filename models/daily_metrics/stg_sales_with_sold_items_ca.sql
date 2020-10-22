{{ config(materialized='table') }}
select sales.date, sales.sales, sold_items.sold_items from {{ref('daily_sales_ca')}} as sales join {{ref('daily_sold_items_ca')}} as sold_items on sales.date=sold_items.date

{{ config(materialized='table') }}
select date_trunc('day', date) date, sum(cost) spend
from adwords.account_stats g_ad
where g_ad.customer_id = '5979709268'
group by date

{{ config(materialized='table') }}
{% for i in range(10) %}

select (select (sum(subtotal_price)*0.76) from shopify_ca.order where date_trunc('day', convert_timezone('gmt', 'pst', created_at)) < date_trunc('week', CURRENT_DATE) - {{4 + i*7}}
                     and date_trunc('day', convert_timezone('gmt', 'pst', created_at)) >= date_trunc('week', CURRENT_DATE) - {{11 + i*7}}) as total_sales,
       (select sum(quantity) from shopify_ca.order_line
           where order_id in
                 (select id from shopify_ca.order where date_trunc('day', convert_timezone('gmt', 'pst', created_at)) < date_trunc('week', CURRENT_DATE) - {{4 + i*7}}
                     and date_trunc('day', convert_timezone('gmt', 'pst', created_at)) >= date_trunc('week', CURRENT_DATE) - {{11 + i*7}})) as sold_items,
    coalesce((
           select sum(spend) from facebook_sofia_rugs.facebook_ad_insights fb_ad
           where fb_ad.account_id = '694710104597812' and
                 date >= date_trunc('week', CURRENT_DATE) - {{11 + i*7}} and
                 date < date_trunc('week', CURRENT_DATE) - {{4 + i*7}}
           ),0) as facebook_spend,
       coalesce((
           select 0
           ),0) as google_spend,
       (facebook_spend + google_spend) as total_spend,
       (total_spend / sold_items) as cost_per_item,
       date_trunc('week', CURRENT_DATE) - {{11 + i*7}} as start_date,
       date_trunc('week', CURRENT_DATE) - {{4 + i*7}} as end_date,
       'CA' as location

{% if not loop.last %} union all {% endif %} 

{% endfor %}
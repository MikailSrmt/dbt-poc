{{ config(materialized='view') }}
select date_trunc('day', date) date, sum(spend) as spend from facebook_sofia_rugs.facebook_ad_insights fb_ad
where fb_ad.account_id = '694710104597812'
group by date

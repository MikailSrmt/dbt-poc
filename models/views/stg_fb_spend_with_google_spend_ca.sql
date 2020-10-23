{{ config(materialized='view') }}
select date, spend as facebook_spend, '0' as google_spend from {{ref('daily_facebook_spend_ca')}}

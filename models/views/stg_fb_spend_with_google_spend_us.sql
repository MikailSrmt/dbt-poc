{{ config(materialized='table') }}
select fb_spend.date, fb_spend.spend as facebook_spend, google_spend.spend as google_spend
from {{ref('daily_facebook_spend_us')}} as fb_spend left outer join {{ref('daily_google_spend_us')}} as google_spend on fb_spend.date=google_spend.date

UNION

select google_spend.date, fb_spend.spend as facebook_spend, google_spend.spend as google_spend
from {{ref('daily_facebook_spend_us')}} as fb_spend right outer join {{ref('daily_google_spend_us')}} as google_spend on fb_spend.date=google_spend.date

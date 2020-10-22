SELECT
    TO_CHAR(DATEADD(day,(0 - extract(dow from dateadd(day,3, daily_growth_metrics.date))::integer), daily_growth_metrics.date), 'YYYY-MM-DD') week,
    COALESCE(SUM(daily_growth_metrics.sales ), 0) AS "sales",
	COALESCE(SUM(daily_growth_metrics.sold_items ), 0) AS "sold_items",
    COALESCE(SUM(daily_growth_metrics.facebook_spend ), 0) AS "facebook_spend",
    COALESCE(SUM(daily_growth_metrics.google_spend ), 0) AS "google_spend"
FROM {{ref('daily_growth_metrics_us')}}  AS daily_growth_metrics
group by 1

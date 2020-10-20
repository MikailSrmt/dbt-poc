{{ config(materialized='table') }}
select p.id, p.name, sum((t.dur / 60000)) as minutes
from toggletoikom.projects p
join toggletoikom.time_entries t on p.id = t.pid
group by 1,2
order by 3 desc

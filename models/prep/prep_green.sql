with cemetry as (
    select
        bezirk,
        cast(replace(flaeche_ha, ',', '.') as float) as cemetry_area
    from {{ ref('stg_cemetry') }}
),

allotment as (
    select
        bezirk,
        cast(replace(flaeche_ha, ',', '.') as float) as allotment_area
    from {{ ref('stg_allotment_gardens') }}
),

public_gardens as (
    select
        bezirk,
        cast(replace(flaeche_ha, ',', '.') as float) as public_garden_area
    from {{ ref('stg_public_gardens') }}
)

select
    c.bezirk,
    c.cemetry_area      as cemetry_area_ha,
    a.allotment_area    as allotment_area_ha,
    p.public_garden_area as public_garden_area_ha
from cemetry c
left join allotment      a using (bezirk)
left join public_gardens p using (bezirk)
order by c.bezirk
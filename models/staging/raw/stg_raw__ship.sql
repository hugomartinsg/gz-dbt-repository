with 

source as (

    select * from {{ source('raw', 'ship') }}

),

renamed as (

    select
        orders_id,
        shipping_fee,
        shipping_fee_1,
        logcost,
        ship_cost

    from source

)

SELECT 
    orders_id,
    shipping_fee,
    logcost,
    ship_cost
FROM 
    {{ source("raw","ship") }}


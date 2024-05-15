WITH orders AS (
  SELECT
    CAST(o.orders_id AS INT64) AS orders_id,
    CAST(o.date_date AS DATE) AS date_date,
    ROUND(
      CAST(o.margin AS FLOAT64) +
      CAST(s.shipping_fee AS FLOAT64) -
      (CAST(s.logcost AS FLOAT64) + CAST(s.ship_cost AS FLOAT64)),
      2
    ) AS operational_margin,
    CAST(o.quantity AS INT64) AS quantity,
    CAST(o.revenue AS FLOAT64) AS revenue,
    CAST(o.purchase_cost AS FLOAT64) AS purchase_cost,
    CAST(o.margin AS FLOAT64) AS margin,
    CAST(s.shipping_fee AS FLOAT64) AS shipping_fee,
    CAST(s.logcost AS FLOAT64) AS logcost,
    CAST(s.ship_cost AS FLOAT64) AS ship_cost
  FROM {{ ref('int_orders_margin') }} o
  LEFT JOIN {{ ref('stg_raw__ship') }} s USING(orders_id)
)
SELECT * FROM orders
ORDER BY orders_id DESC
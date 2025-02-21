/* syntax version 1 */
/* postgres can not */
SELECT
    value,
    SUM(unwrap(CAST(subkey AS uint32))) OVER w1 AS sum1,
    LEAD(value || value, 3) OVER w1 AS dvalue_lead1,
    SUM(CAST(subkey AS uint32)) OVER w2 AS sum2,
    LAG(CAST(value AS uint32)) OVER w2 AS value_lag2,
FROM (
    SELECT
        *
    FROM plato.Input
    WHERE key == '1'
)
WINDOW
    w1 AS (
        PARTITION BY
            key
        ORDER BY
            value
        ROWS BETWEEN UNBOUNDED PRECEDING AND 3 PRECEDING
    ),
    w2 AS (
        PARTITION BY
            key
        ORDER BY
            value
        ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
    )
ORDER BY
    value;

PRAGMA DisableSimpleColumns;

SELECT
    Input1.key,
    Input1.subkey,
    Input3.value
FROM plato.Input1
INNER JOIN plato.Input3
ON Input1.key == Input3.key;

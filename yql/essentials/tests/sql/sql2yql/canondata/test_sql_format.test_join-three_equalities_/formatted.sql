PRAGMA DisableSimpleColumns;
USE plato;

SELECT
    *
FROM Input1
    AS A
JOIN Input2
    AS B
ON A.key == B.key
    AND (CAST(A.subkey AS int) + 1 == CAST(B.subkey AS int))
    AND A.value == B.value
ORDER BY
    A.key;

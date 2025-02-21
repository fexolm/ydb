USE plato;
PRAGMA yt.JoinMergeForce = "1";
PRAGMA yt.JoinMergeTablesLimit = "10";

$join =
    SELECT
        a.key AS key1,
        a.subkey AS subkey1
    FROM (
        SELECT
            *
        FROM Input8
        WHERE subkey != "bar"
    )
        AS a
    JOIN (
        SELECT
            *
        FROM Input8
        WHERE subkey != "foo"
    )
        AS b
    ON a.key == b.key AND a.subkey == b.subkey;

SELECT
    key1,
    subkey1,
    count(*)
FROM $join
GROUP COMPACT BY
    subkey1,
    key1;

SELECT
    key1,
    subkey1
FROM $join
GROUP COMPACT BY
    key1,
    subkey1;

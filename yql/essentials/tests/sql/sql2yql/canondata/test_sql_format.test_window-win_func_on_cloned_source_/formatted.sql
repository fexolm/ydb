/* postgres can not */
USE plato;

$sub_raws = (
    SELECT
        ROW_NUMBER() OVER trivialWindow AS RowNum
    FROM Input
    WINDOW
        trivialWindow AS ()
);

--INSERT INTO Output
SELECT
    *
FROM $sub_raws;

SELECT
    *
FROM $sub_raws;

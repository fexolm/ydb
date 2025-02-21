/* syntax version 1 */
/* postgres can not */
USE plato;
$combineQueries = ($query, $list) -> {
    RETURN EvaluateCode(
        LambdaCode(
            ($world) -> {
                $queries = ListMap(
                    $list, ($arg) -> {
                        RETURN FuncCode("Apply", QuoteCode($query), $world, ReprCode($arg))
                    }
                );
                RETURN FuncCode("Extend", $queries);
            }
        )
    );
};

DEFINE ACTION $aaa($z) AS
    $k = (
        SELECT
            count(*)
        FROM $z
    );

    DEFINE SUBQUERY $sub($n) AS
        SELECT
            $n + $k
        FROM $z;
    END DEFINE;
    $fullQuery = $combineQueries($sub, ListFromRange(0, 10));

    SELECT
        *
    FROM $fullQuery();
END DEFINE;

EVALUATE FOR $z IN AsList("Input") DO
    $aaa($z)
;
DO
    $aaa("Input")
;

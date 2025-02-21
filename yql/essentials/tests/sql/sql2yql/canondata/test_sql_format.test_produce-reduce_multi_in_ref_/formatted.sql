/* syntax version 1 */
/* postgres can not */
USE plato;
$udf = YQL::@@
(lambda '(key stream) 
    (PartitionByKey stream
        (lambda '(item) (Way item))
        (Void)
        (Void)
        (lambda '(listOfPairs)
            (FlatMap listOfPairs
                (lambda '(pair) (Just (AsStruct '('key key) '('src (Nth pair '0)) '('cnt (Length (ForwardList (Nth pair '1)))))))
            )
        )
    )
)
@@;

$src = (
    SELECT
        *
    FROM plato.Input
    WHERE key > "200"
);

$r = (
    REDUCE Input, (
        SELECT
            *
        FROM Input
        WHERE key > "100"
    ), $src
    ON
        key
    USING $udf(TableRow())
);

SELECT
    key,
    src,
    cnt
FROM $r
ORDER BY
    key,
    src,
    cnt;

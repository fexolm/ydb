/* postgres can not */
/* syntax version 1 */
USE plato;
$udfScript = @@
def Len(val_key, input):
    return {"joined": {val_key: b", ".join(input)}}
@@;
$udf = Python3::Len(Callable<(String, Stream<String>) -> Struct<joined: Dict<String, String>>>, $udfScript);

--INSERT INTO Output
$res = (
    REDUCE Input1
    PRESORT
        value DESC
    ON
        key
    USING $udf(subkey)
);

SELECT
    *
FROM $res
ORDER BY
    Yql::ToOptional(Yql::DictKeys(joined));

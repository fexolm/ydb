/* syntax version 1 */
/* postgres can not */
$key_text = AsDict(
    ('911', 'emergency'),
    ('200', 'two hundred'),
    ('150', 'one and half hundred'),
    ('023', 'funny'),
    ('075', '3/4 of hundred')
);

SELECT
    value,
    $key_text[key] AS key_text
FROM plato.Input;

SELECT 
id, 
name 
from 
stations 
WHERE
parent_station_id IS NULL
ORDER BY frequency ASC LIMIT 7

SELECT 
id,
name,
streaming_hour,
end_streaming_hour,
station_id
FROM
timetables 
WHERE 
thursday = true AND 
CAST(streaming_hour AS TIME) <= CAST (NOW() AS TIME) AND
CAST(end_streaming_hour AS TIME) >= CAST(NOW() AS TIME)

SELECT
s.id, 
s.name,
tb.id,
tb.name,
tb.streaming_hour,
tb.end_streaming_hour,
tb.station_id
FROM
stations AS s
INNER JOIN timetables AS tb ON s.id = tb.station_id 
WHERE 
tb.thursday = true AND
cast(tb.streaming_hour AS TIME) <= CAST (NOW() AS TIME) AND
cast(tb.end_streaming_hour AS TIME) >= CAST(NOW() AS TIME) AND
s.parent_station_id IS NULL
ORDER BY s.frequency ASC LIMIT 7

SELECT * FROM stations WHERE name LIKE '%La Q%'
SELECT * FROM timetables WHERE station_id = 184

INSERT INTO timetables(
    streaming_hour, 
    name, 
    image, 
    created_at, 
    updated_at, 
    station_id, 
    end_streaming_hour, 
    monday, 
    tuesday, 
    wednesday, 
    thursday, 
    friday, 
    saturday, 
    sunday, 
    broadcasters, 
    broadcaster_image, 
    description
)
VALUES(
'00:00:00',
'3. LA Q',
'//globalmediarocks.s3-us-west-1.amazonaws.com/uploads/d1e0802b-ceba-49d4-9a78-ba73f652b852/PASCAL.png',
'2021-02-08 09:19:19.046842',
'2021-05-25 17:21:19.828755',
184,
'23:59:59',
true,
true,
true,
true,
true,
true,
true,
'Pascal Beltrán del Río',
'//globalmediarocks.s3-us-west-1.amazonaws.com/uploads/568aa146-37ef-4a8f-b280-5bdb201aeb76/imagen_400px.jpg',
''
)

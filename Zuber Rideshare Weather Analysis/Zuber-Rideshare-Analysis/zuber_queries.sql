Prompt:
Retrieve from the trips table all the rides that started in the Loop (pickup_location_id: 50) on a Saturday and ended at O'Hare (dropoff_location_id: 63). 
  Get the weather conditions for each ride. Use the method you applied in the previous task. 
  Also, retrieve the duration of each ride. Ignore rides for which data on weather conditions is not available.

Query:
  SELECT 
    t.start_ts,
    CASE 
        WHEN w.description LIKE '%rain%' OR w.description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
    END AS weather_conditions,
    t.duration_seconds
FROM trips t
INNER JOIN weather_records w ON t.start_ts = w.ts
WHERE 
    t.pickup_location_id = 50 
    AND t.dropoff_location_id = 63
    AND EXTRACT(DOW FROM t.start_ts) = 6
ORDER BY t.trip_id;

Query 1: Date specific trips quantity for all recorded taxi businesses.
 
SELECT 
    c.company_name, 
    COUNT(t.trip_id) AS trips_amount
FROM trips t
JOIN cabs c ON t.cab_id = c.cab_id
WHERE t.start_ts BETWEEN '2017-11-15 00:00:00' AND '2017-11-16 23:59:59'
GROUP BY c.company_name
ORDER BY trips_amount DESC;

Query 2: Weekly trip quanties, seperating the top two carriers with others grouped.
SELECT 
    CASE 
        WHEN c.company_name = 'Flash Cab' THEN 'Flash Cab'
        WHEN c.company_name = 'Taxi Affiliation Services' THEN 'Taxi Affiliation Services'
        ELSE 'Other'
    END AS company,
    COUNT(t.trip_id) AS trips_amount
FROM trips t
JOIN cabs c ON t.cab_id = c.cab_id
WHERE t.start_ts BETWEEN '2017-11-01 00:00:00' AND '2017-11-07 23:59:59'
GROUP BY company
ORDER BY trips_amount DESC;

Query 3: Duration and weather of trips to airport locations on a specific Saturday.
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

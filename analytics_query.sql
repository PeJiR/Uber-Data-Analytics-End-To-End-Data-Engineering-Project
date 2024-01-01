SELECT
  VendorID,
  AVG(fare_amount) AS avg_fare_amount
FROM
  uber-409912.uber_data_eng.fact_table
GROUP BY
  VendorID;
SELECT
  b.payment_type_name,
  AVG(a.tip_amount) AS avg_tip_amount
FROM
  uber-409912.uber_data_eng.fact_table a
JOIN
  uber-409912.uber_data_eng.payment_type_dim b
ON
  a.payment_type_id = b.payment_type_id
GROUP BY
  b.payment_type_name;
  
  -- Find the top 10 pickup locations based on the number of trips
SELECT
  pick.pickup_location_id,
  COUNT(f.trip_id) AS total_trips
FROM
  uber-409912.uber_data_eng.fact_table f
JOIN
  uber-409912.uber_data_eng.pickup_location_dim pick
ON
  f.pickup_location_id = pick.pickup_location_id
GROUP BY
  pick.pickup_location_id
ORDER BY
  total_trips DESC
LIMIT
  10;
  
  -- Find the total number of trips by passenger count
SELECT
  p.passenger_count,
  COUNT(f.trip_id) AS total_trips
FROM
  uber-409912.uber_data_eng.fact_table f
JOIN
  uber-409912.uber_data_eng.passenger_count_dim p
ON
  f.passenger_count_id = p.passenger_count_id
GROUP BY
  p.passenger_count;
  
  -- Find the average fare amount by hour of the day
SELECT
  d.pick_hour AS pickup_hour,
  AVG(f.fare_amount) AS avg_fare_amount
FROM
  uber-409912.uber_data_eng.fact_table f
JOIN
  uber-409912.uber_data_eng.datetime_dim d
ON
  f.datetime_id = d.datetime_id
GROUP BY
  d.pick_hour;


------------------


SELECT
  f.trip_id,
  f.VendorID,
  d.tpep_pickup_datetime AS pickup_datetime,
  d.tpep_dropoff_datetime AS dropoff_datetime,
  p.passenger_count,
  t.trip_distance,
  r.rate_code_name,
  pick.pickup_latitude,
  pick.pickup_longitude,
  drop.dropoff_latitude,
  drop.dropoff_longitude,
  pay.payment_type_name,
  f.fare_amount,
  f.extra,
  f.mta_tax,
  f.tip_amount,
  f.tolls_amount,
  f.improvement_surcharge,
  f.total_amount
FROM
  uber-409912.uber_data_eng.fact_table f
JOIN
  uber-409912.uber_data_eng.datetime_dim d
ON
  f.datetime_id = d.datetime_id
JOIN
  uber-409912.uber_data_eng.passenger_count_dim p
ON
  f.passenger_count_id = p.passenger_count_id
JOIN
  uber-409912.uber_data_eng.trip_distance_dim t
ON
  f.trip_distance_id = t.trip_distance_id
JOIN
  uber-409912.uber_data_eng.rate_code_dim r
ON
  f.rate_code_id = r.rate_code_id
JOIN
  uber-409912.uber_data_eng.pickup_location_dim pick
ON
  f.pickup_location_id = pick.pickup_location_id
JOIN
  uber-409912.uber_data_eng.dropoff_location_dim DROP
ON
  f.dropoff_location_id = drop.dropoff_location_id
JOIN
  uber-409912.uber_data_eng.payment_type_dim pay
ON
  f.payment_type_id = pay.payment_type_id; 
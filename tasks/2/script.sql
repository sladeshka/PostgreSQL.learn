SELECT * FROM aircrafts;

-- first error aircraft_code
SELECT aircraft_code, model
FROM aircrafts;

SELECT model, range
FROM bookings.aircrafts_data
WHERE range < 5000;

-- second error pasenger_name
SELECT book_ref, passenger_id, passenger_name
FROM bookings.tickets
WHERE passenger_name LIKE 'V%'
    OR passenger_name LIKE 'E%';

-- third error departure_airoport, arrival_airoport
SELECT flight_no, scheduled_departure, scheduled_arrival,
departure_airport, arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
    AND scheduled_departure BETWEEN '2017-08-31' AND '2017-09-01';

SELECT flight_no ,scheduled_departure, scheduled_arrival,
departure_airport, arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
    AND arrival_airport IN ('LED','KZN')
    AND scheduled_departure between '2017-08-31' and '2017-09-01';

-- has error
SELECT
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    actual_departure,
    actual_arrival
FROM bookings.flights
WHERE departure_airport = 'DME'
AND actual_departure = NULL;


SELECT
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    actual_departure,
    actual_arrival
FROM bookings.flights
WHERE departure_airport = 'DME'
AND actual_departure IS NULL;

SELECT
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    COALESCE(actual_departure, '9999-12-31'),
    COALESCE(actual_arrival, '9999-12-31')
FROM bookings.flights
WHERE departure_airport = 'DME'
AND arrival_airport = 'KZN';

SELECT
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    COALESCE(actual_departure, '9999-12-31') AS "Actual Departure",
    COALESCE(actual_arrival, '9999-12-31') "Actual Arrival"
FROM bookings.flights
WHERE departure_airport = 'DME'
AND arrival_airport = 'KZN';

SELECT
    scheduled_departure,
    flight_no,
    COALESCE(actual_departure::varchar, 'CANCELED') AS "Actual Departure"
FROM bookings.flights
WHERE departure_airport = 'DME'
AND arrival_airport = 'KZN';

SELECT
    scheduled_departure,
    flight_no,
    departure_airport,
    arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
ORDER BY arrival_airport;

SELECT
    scheduled_departure,
    flight_no,
    departure_airport,
    arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
ORDER BY arrival_airport, scheduled_departure DESC;

SELECT DISTINCT
    departure_airport,
    arrival_airport
FROM bookings.flights
ORDER BY 1,2;

-- || fourth error departure_airoport, arrival_airoport
SELECT
    scheduled_departure,
    'FROM' || departure_airport::varchar || ' to ' || arrival_airport::varchar AS Destination,
    status
FROM bookings.flights;

-- fifth error booking 
SELECT
    book_ref,
    substring(passenger_name from 1 for position(' 'in passenger_name)) as Name,
    substring(passenger_name from position(' 'in passenger_name)) as Surname
FROM bookings.tickets;

-- sixth error "Economy"
SELECT
    AVG(amount) AS Average,
    SUM(amount) as Summary
FROM bookings.ticket_flights
WHERE fare_conditions = 'Economy';

SELECT
    COUNT(*)
FROM bookings.ticket_flights
WHERE fare_conditions = 'Economy';

SELECT
    COUNT(*)
FROM bookings.flights
WHERE COALESCE(actual_arrival::date,'2017-06-12') = '2017-06-12';

SELECT
    COUNT(actual_arrival)
FROM bookings.flights
WHERE COALESCE(actual_arrival::date,'2017-06-12') = '2017-06-12';

SELECT
    COUNT(DISTINCT departure_airport)
FROM bookings.flights;

-- seventh error GROUP BY departure_airport;
SELECT
    departure_airport,
    count(actual_arrival)
FROM bookings.flights
GROUP BY departure_airport;

SELECT
    departure_airport,
    count(actual_arrival)
    FROM bookings.flights
GROUP BY departure_airport;

SELECT
    departure_airport,
    count(actual_arrival)
    FROM bookings.flights
GROUP BY departure_airport
HAVING count(actual_arrival) < 50;

SELECT
    departure_airport,
    arrival_airport,
    count(actual_arrival)
    FROM bookings.flights
    GROUP BY ROLLUP (departure_airport, arrival_airport)
HAVING count(actual_arrival) > 300;

SELECT
    departure_airport,
    arrival_airport,
    count(actual_arrival)
    FROM bookings.flights
    GROUP BY CUBE (departure_airport, arrival_airport)
HAVING count(actual_arrival) > 300;
CREATE DATABASE murder_case;
USE forensics;

SELECT * FROM call_records_large;
SELECT * FROM access_logs_large;
SELECT * FROM suspects_large;
SELECT * FROM forensic_events_large;

-- who killed Ronald Greene
SELECT s.suspect_id,name, access_time,door_accessed,alibi, success_flag
FROM suspects_large s
JOIN access_logs_large a ON s.suspect_id = a.suspect_id
WHERE access_time BETWEEN "2025-06-01 19:50:00" AND "2025-06-01 20:03:00"
AND door_accessed = "vault room" AND success_flag = "TRUE";
-- ROBIN AHMED

-- who are the top 3 suspects and why
SELECT a.suspect_id, name,access_time, relation_to_victim
FROM access_logs_large a
JOIN suspects_large s ON s.suspect_id = a.suspect_id
WHERE door_accessed = "vault room" AND success_flag = "true"
AND access_time BETWEEN '2025-06-01 19:50:00' AND '2025-06-01 20:03:00'
GROUP BY suspect_id,name, access_time, relation_to_victim
ORDER BY access_time desc
LIMIT 3;
-- Jamie Bennett,Robin Ahmed and Samira Shaw

-- whose alibi does not match the forensic timeline
SELECT a.suspect_id, name, alibi, access_time,door_accessed
FROM suspects_large s 
JOIN access_logs_large a ON s.suspect_id = a.suspect_id
WHERE access_time BETWEEN '2025-06-01 19:45:00' AND '2025-06-01 20:03:00'
AND alibi != door_accessed;
-- All the suspects

-- was anyone in the vault room shortly before or after the murder time 8pm
SELECT a.suspect_id, name,alibi,access_time, door_accessed,success_flag
FROM access_logs_large a
JOIN suspects_large s ON s.suspect_id = a.suspect_id
WHERE door_accessed = "vault room" AND success_flag = "true"
AND access_time BETWEEN '2025-06-01 19:55:00' AND '2025-06-01 20:05:00';
-- yes and they are Robin Ahmed,Victor Shaw and Jamie Bennett

-- what does the call log reveal about the final phone call
SELECT s.suspect_id,name,call_time,call_duration,alibi,recipient_relation FROM call_records_large c
JOIN suspects_large s ON s.suspect_id = c.suspect_id
WHERE call_time BETWEEN '2025-06-01 19:50:00' AND '2025-06-01 20:05:00'
AND recipient_relation = "VICTIM";
-- the final call was from Susan Knight and she is a suspect


-- are there and inconsistencies between the door access log and alibis claim YES

-- WHAT does forensic timeline says about the time and manner of death
SELECT * FROM forensic_events_large;


-- Which suspect movement pattern overlaps the critical time window
SELECT s.suspect_id,name,alibi,access_time,door_accessed,success_flag FROM suspects_large s
JOIN access_logs_large a ON s.suspect_id = a.suspect_id
WHERE access_time BETWEEN '2025-06-01 19:55:00' AND '2025-06-01 20:05:00';
-- Robin Ahmed

-- How did the data source contradict or confirm one another

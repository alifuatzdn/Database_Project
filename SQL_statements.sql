# 1. Find the maximum and minimum heart_rate recorded for each user, grouped by user_id.
select u.user_id, MAX(r.heart_rate) as max_heart_rate, MIN(r.heart_rate) as min_heart_rate
from users u 
join readings r on u.user_id = r.user_id
group by u.user_id;

# 2. What is the average stress_score and average hrv_rmssd for users, grouped by gender, for users whose weight are greater than 70?
select u.gender, AVG(r.stress_score) as avg_stress_score, AVG(r.hrv_rmssd) as avg_hrv_rmssd
from users u
join readings r on u.user_id = r.user_id
JOIN users_physical up ON u.user_id = up.user_id
WHERE up.weight_kg > 70
group by u.gender;

# 3. Calculate the total sum of calories_5min burned and total sum of steps_5min taken, grouped by activity_type.
select SUM(ra.calories_5min) as total_calories, SUM(ra.steps_5min) as total_step , ra.activity_type
from readings_activity ra
group by ra.activity_type;

# 4. What is the average resting_hr and average hrv_rmssd grouped by caffeine_user status, for users over 35 years old?
select ul.caffeine_user, AVG(ub.resting_hr) as avg_resting_hr , AVG(rh.hrv_rmssd) as avg_hrv_rmssd
from users_lifestyle ul
join users_baselines ub on ul.user_id = ub.user_id
join readings_heart rh on ul.user_id = rh.user_id
join users_physical up on ul.user_id = up.user_id
where up.age > 35
group by ul.caffeine_user;

# 5. Compute the average resting_hr and average bmi for users, grouped by whether they are a smoker or not.
select ul.smoker, AVG(ub.resting_hr) as avg_resting_hr, AVG(ROUND(up.weight_kg / POW(up.height_cm / 100, 2), 2)) AS avg_bmi_score
from users_physical up
join users_lifestyle ul on ul.user_id = up.user_id
join users_baselines ub on ub.user_id = up.user_id
group by ul.smoker;

# 6. What is the total count of anomaly grouped by anomaly_severity?
select ra.anomaly_severity, SUM(ra.is_anomaly) as total_anomaly_count
from readings_anomalies ra
group by ra.anomaly_severity;

# 7. Calculate the average skin_temperature and heart_rate of users, grouped by user_id, for the intensity greater than 0.4.
select r.user_id, AVG(ra.skin_temperature) as avg_skin_temperature, AVG(r.heart_rate) as avg_heart_rate
from readings r
join readings_activity ra on r.user_id = ra.user_id and r.timestamp = ra.timestamp  
where ra.activity_intensity > 0.4    
group by r.user_id;

# 8. Find the minimum and maximum recorded skin_temperature, grouped by the user's fitness_level.
select ul.fitness_level, MIN(ra.skin_temperature) as min_skin_temperature, MAX(ra.skin_temperature) as max_skin_temperature
from readings_activity ra
join users_lifestyle ul on ra.user_id = ul.user_id
group by ul.fitness_level;

# 9. Find the average heart_rate for users, grouped by sleep_stage, filtering only for the rem_sleep stages.
select rs.sleep_stage, AVG(r.heart_rate) as avg_heart_rate
from readings r
join readings_sleep rs on r.user_id = rs.user_id and r.timestamp = rs.timestamp
where rs.sleep_stage = "rem_sleep"
group by rs.sleep_stage;

# 10. Compute the average age and count of users, grouped by performance_level and gender.
select u.gender, ul.performance_level, AVG(up.age) as avg_age, COUNT(u.user_id) as total_users
from users u
join users_lifestyle ul on u.user_id = ul.user_id
join users_physical up on ul.user_id = up.user_id
group by u.gender, ul.performance_level;


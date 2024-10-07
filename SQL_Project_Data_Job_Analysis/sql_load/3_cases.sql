-- January
CREATE TABLE january_job AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_job AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_job AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM march_job;


SELECT 
   COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM   
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
   location_category;

/* Results:
High Salary -- 43
Low Salary -- 3352
Standard salary -- 2068
No Info 191130 */


SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN salary_year_avg IS NULL THEN 'No info'
        WHEN salary_year_avg < 100000 THEN 'Low salary'
        WHEN salary_year_avg BETWEEN 100000 AND 200000 THEN 'Standard Salary'
        WHEN salary_year_avg > 200000 THEN 'High salary'
        ELSE 'No info'
    END AS salary_standards
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    salary_standards
ORDER BY
    number_of_jobs DESC;

-- checking how many Data Analyst jobs has salary = null
SELECT
     COUNT(job_id) AS number_of_jobs
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NULL
    AND
    job_title_short = 'Data Analyst'

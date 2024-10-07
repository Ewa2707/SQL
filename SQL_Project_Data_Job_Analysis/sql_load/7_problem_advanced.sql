-- comment

SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::date,
    salary_year_avg
FROM (

    SELECT *
    FROM january_job
    UNION ALL
    SELECT *
    FROM feburary_job
    UNION ALL
    SELECT *
    FROM march_job

) AS quarter1_job_postings

WHERE
    salary_year_avg > 70000
    AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;
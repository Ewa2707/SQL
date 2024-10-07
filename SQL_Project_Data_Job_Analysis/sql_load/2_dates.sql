SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
 FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    date_month
ORDER BY
   job_posted_count DESC;

SELECT *
FROM (
    SELECT
        job_title,
        job_title_short,
        job_posted_date
        FROM job_postings_fact
        WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) AS january_jobs;
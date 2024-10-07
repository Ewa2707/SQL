SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = TRUE
    ORDER BY
        company_id
)
SELECT 
    company_id,
    name AS company_name
FROM  
    company_dim
 WHERE company_id IN (   
        SELECT
            company_id
        FROM    
            job_postings_fact
        WHERE
            job_no_degree_mention = true
        ORDER BY
            company_id
 )

-------------------------------------------------

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC

---------------------------------------------------

WITH most_mentioned_jobs AS (
    SELECT
        skill_id,
        COUNT(*) AS total_jobs_with_skill
        FROM
            skills_job_dim
        GROUP BY
            skill_id
            )

SELECT
    skills_dim.skill_id AS id_skill,
    skills_dim.skills AS skill,
    most_mentioned_jobs.total_jobs_with_skill AS total
FROM skills_dim
LEFT JOIN most_mentioned_jobs ON most_mentioned_jobs.skill_id = skills_dim.skill_id
ORDER BY
    total_jobs_with_skill DESC
LIMIT 10;

-----------------------------------------------------

-- count how many posting have company

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT
        total_jobs,
        company_id,
    CASE
        WHEN total_jobs < 10 THEN 'Small'
        WHEN total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        WHEN total_jobs > 50 THEN 'Large'
        ELSE 'No info'
        END AS company_size
FROM company_job_count
GROUP BY
    company_job_count.company_id,
    company_job_count.total_jobs
ORDER BY
    total_jobs DESC;

------------------------------------------------------


-- mentioned how many skills and ID skills is for the job
SELECT *
FROM skills_job_dim
LIMIT 10;

-- job_posting table view
SELECT *
FROM job_postings_fact
LIMIT 10;


-- mentioned what kind of skill it is
SELECT *
FROM skills_dim
LIMIT 10;

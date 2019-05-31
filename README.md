# bigquery-recipes


SELECT
  device.language,
  COUNT(DISTINCT clientId) AS users,
  SUM(totals.newVisits) AS new_users,
  SUM(totals.visits) AS sessions,
  ROUND(SUM(totals.visits) / COUNT(DISTINCT clientId), 2) AS num_sessions_per_user,
  SUM(totals.pageviews) AS pageviews,
  ROUND(SUM(totals.pageviews) / SUM(totals.visits), 2) AS pages_per_session,
  SUM(totals.timeOnSite) / SUM(totals.visits) AS avg_session_duration_secs,
  ROUND((SUM(totals.bounces) / SUM(totals.visits)) * 100, 2) AS bounce_rate
FROM
  `PROJECT_ID.DATASET.ga_sessions_YYYYMMDD`
  GROUP BY device.language
  ORDER BY sessions DESC

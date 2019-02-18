#standardSQL
SELECT
  channel,
  sessions,
  pageviews,
  bounces,
  (( bounces / sessions ) * 100 ) AS bounce_rate,
  ROUND((pageviews / sessions), 2) AS pages_per_session,
  ((transactions / sessions) * 100) AS ecommerce_conversion_rate,
  transactions,
  (revenue / 1000000) AS revenue
FROM (
  SELECT
    channelGrouping AS channel,
    COUNT(totals.visits) AS sessions,
    SUM(totals.bounces) AS bounces,
    SUM(totals.pageviews) AS pageviews,
    SUM(totals.transactions) AS transactions,
    SUM(totals.totalTransactionRevenue) AS revenue
  FROM
    `omega-post-184817.139139762.ga_sessions_*`
  WHERE
    _TABLE_SUFFIX BETWEEN '20181101'
    AND '20181130'
  GROUP BY
    channel )
ORDER BY
  sessions DESC

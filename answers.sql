#1
SELECT marketing_data.date, SUM(marketing_data.impressions) AS sum_impressions
FROM marketing_data 
GROUP BY marketing_data.date
ORDER BY marketing_data.date;

#2
SELECT website_revenue.state, SUM(website_revenue.revenue) AS sum_revenue
FROM website_revenue
GROUP BY website_revenue.state
ORDER BY website_revenue.sum_revenue DESC
LIMIT 3;

#3
SELECT SUM(marketing_data.cost) AS sum_cost, marketing_data.sum_impressions, SUM(marketing_data.clicks) AS sum_clicks, website_revenue.sum_revenue, campaign_info.name
FROM campaign_info
LEFT JOIN marketing_data ON campaign_info.id = marketing_data.campaign_id
LEFT JOIN website_revenue ON campaign_info.id = website_revenue.campaign_id
GROUP BY campaign_info.name;

#4
SELECT website_revenue.state, SUM(marketing_data.conversions) AS sum_conversions
FROM marketing_data
JOIN website_revenue ON marketing_data.campaign_id = website_revenue.campaign_id
WHERE marketing_data.campaign_id = 'Campaign5'
GROUP BY website_revenue.state
ORDER BY total_conversions DESC
LIMIT 1;

#5
SELECT campaign_info.name, (website_revenue.sum_revenue / SUM(marketing_data.cost)) AS Profits
FROM campaign_info
LEFT JOIN marketing_data ON campaign_info.id = marketing_data.campaign_id
LEFT JOIN website_revenue ON campaign_info.id = website_revenue.campaign_id
GROUP BY campaign_info.name
ORDER BY Profits DESC
LIMIT 1;
  
#6
SELECT
  CASE
    WHEN DAYOFWEEK(date) = 1 THEN 'Sunday'
    WHEN DAYOFWEEK(date) = 2 THEN 'Monday'
    WHEN DAYOFWEEK(date) = 3 THEN 'Tuesday'
    WHEN DAYOFWEEK(date) = 4 THEN 'Wednesday'
    WHEN DAYOFWEEK(date) = 5 THEN 'Thursday'
    WHEN DAYOFWEEK(date) = 6 THEN 'Friday'
    WHEN DAYOFWEEK(date) = 7 THEN 'Saturday'
  END AS Best_Ad_Day
FROM
  marketing_data
GROUP BY
  Best_Ad_Day
ORDER BY
  SUM(impressions + clicks + conversions) DESC
LIMIT 1;

-- Reusable view (optional but recommended)
CREATE VIEW IF NOT EXISTS joined_donors AS
SELECT
  u.email,
  u.subscription_status,         -- app status
  u.created_at,
  u.country,
  u.stripe_subscription_id,
  u.is_active,
  u.subscription_tier,
  s."Customer_ID",
  s.status AS stripe_status,     -- stripe status
  s.customer_email
FROM users u
LEFT JOIN subscriptionsstripe s
  ON u.email = s.customer_email;
  
-- Uses first 7 chars (YYYY-MM) to avoid timezone parsing issues
SELECT
  SUBSTR(created_at, 1, 7) AS month,
  COUNT(DISTINCT email)    AS signups
FROM users
GROUP BY month
ORDER BY month;

--2) Active vs inactive users
SELECT
  is_active,
  COUNT(*) AS users
FROM joined_donors
GROUP BY is_active
ORDER BY users DESC;

--3) Subscription tier distribution
SELECT
  subscription_tier,
  COUNT(*) AS users
FROM joined_donors
GROUP BY subscription_tier
ORDER BY subscription_tier;

--4) Top countries
SELECT
  COALESCE(NULLIF(TRIM(country), ''), 'Unknown') AS country,
  COUNT(*) AS users
FROM joined_donors
GROUP BY country
ORDER BY users DESC
LIMIT 10;

--5) Status consistency check (App vs Stripe)
-- Contingency table counts
SELECT
  subscription_status AS app_status,
  stripe_status       AS stripe_status,
  COUNT(*)            AS users
FROM joined_donors
GROUP BY app_status, stripe_status
ORDER BY users DESC;

--6) Users without a Stripe record (orphaned in app)
SELECT *
FROM joined_donors
WHERE "Customer_ID" IS NULL;

--7) Revenue proxy per month (sum of tiers)
SELECT
  SUBSTR(created_at, 1, 7) AS month,
  SUM(COALESCE(subscription_tier, 0)) AS monthly_amount_eur
FROM joined_donors
-- Optional: only Stripe-active
-- WHERE LOWER(stripe_status) = 'active'
GROUP BY month
ORDER BY month;













    
    



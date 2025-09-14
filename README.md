Donor & Subscription Analytics – SQL + Python ML

This project analyzes donor subscription data (from app users and Stripe exports), combining SQL queries, data visualization, and machine learning to derive insights for both portfolio demonstration and real decision-making.

📁 Project Structure
.
├── users.csv                 # Users dataset (exported from app)
├── subscriptions_stripe.csv  # Stripe subscriptions dataset
├── Joined_Table.csv          # Joined dataset (users + subscriptions)
├── queries.sql               # SQL queries for analysis
├── data_vis_ml.py            # Python script for visualizations + ML
├── Data_Vis_ML.ipynb         # Jupyter Notebook version
└── README.md                 # Project documentation

🗄️ SQL Analysis

The SQL queries (in queries.sql) cover:

User Growth – Signups per month

Active vs Inactive Users

Subscription Tier Distribution

Top Countries by donors

App vs Stripe Status consistency

Revenue per Month (EUR)

📊 Data Visualization

The Python script (data_vis_ml.py) generates:

Bar chart: User signups per month

Pie chart: Active vs Inactive users

Bar chart: Subscription tier distribution

Horizontal bar chart: Top 10 countries

Crosstab: App vs Stripe status

ARIMA plot: Monthly revenue forecast (with confidence interval)

🤖 Machine Learning Experiments
1. Churn Prediction

Target: is_active (churn vs active).

Models: Logistic Regression, Random Forest + SMOTE.

Result: Model could not reliably detect churn due to severe imbalance (54 active vs 4 churners).

Lesson: More churn examples needed before predictive modeling.

2. Subscription Tier Prediction

Target: subscription_tier (3, 8, 10, 15, 20, 150).

Model: Decision Tree Classifier.

Result: Performed poorly due to extreme class imbalance.

Lesson: Grouping into broader categories improves performance slightly (macro-F1 ≈ 0.35), but more data required.

3. Revenue Forecasting

Target: Monthly sum of subscription_tier.

Model: ARIMA.

Result: Forecast is illustrative only (3 months of history).

Lesson: Time-series forecasting requires more historical data (12+ months).

📝 Key Insights

Most donors are in lower tiers (3–8 EUR).

Greece dominates user base, but international donors exist.

Stripe and app statuses are fully synced.

Churn detection models fail with current imbalance (need more churn data).

Revenue forecasting shows methodology but requires longer history.

🚀 Future Work

Collect more churn and high-donor examples.

Merge Stripe + app data over longer timeframes (12+ months).

Try binary donor segmentation (Low vs High) instead of many tiers.

Expand features: donation frequency, campaign participation, volunteer activity.

⚙️ Tech Stack

SQL (SQLite) – joins, aggregations, data cleaning.

Python (Pandas, Matplotlib, scikit-learn, imbalanced-learn, statsmodels) – visualization & ML.

Google Colab – reproducible analysis.

Orphaned Users (users with no Stripe record)

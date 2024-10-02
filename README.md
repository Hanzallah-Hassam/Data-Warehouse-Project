
# E-commerce Data Warehouse Project
![image](https://github.com/user-attachments/assets/219d8dce-69a8-458a-ab40-8b3eed0eefd6)

![Screenshot 2024-10-01 233653](https://github.com/user-attachments/assets/02681a7d-4c7b-444c-8c9c-160c99a34ba0)

**Data Source :**  https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data

This project demonstrates how to set up a data warehouse for an e-commerce platform using **Snowflake** and **dbt**. It includes database and schema creation, data ingestion, and data transformations for analytics and machine learning (NLP on product reviews).

## Project Setup

### Prerequisites
Before starting, make sure you have:
- A Snowflake account.
- `dbt` installed.
- The Brazilian e-commerce dataset.
- Snowflake credentials configured.

### Step 1: Snowflake Setup

Run the following commands to create your database, schemas, roles, and assign permissions:

1. **Create Database and Schemas:**

```sql
CREATE DATABASE GlobalMart;
USE DATABASE GlobalMart;

CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS analytics;
CREATE SCHEMA IF NOT EXISTS ml;
```

2. **Create Roles and Users:**

```sql
CREATE ROLE data_engineer_role;
CREATE ROLE data_analyst_role;

GRANT ROLE data_engineer_role TO USER <your_user>;
GRANT ROLE data_analyst_role TO USER <your_user>;
```

3. **Assign Permissions:**

```sql
GRANT USAGE ON DATABASE GlobalMart TO ROLE data_engineer_role;
GRANT USAGE ON SCHEMA GlobalMart.staging TO ROLE data_engineer_role;
GRANT SELECT ON ALL TABLES IN SCHEMA GlobalMart.staging TO ROLE data_analyst_role;
```

### Step 2: Data Ingestion

Create a stage and upload all the files their then, To ingest data into the  schema, use the `snowflake_data_ingestion.sql` script.


### Step 3: DBT Code Overview

The dbt models are structured into three layers:

1. **Staging Models:**
   - These models clean the raw data in the `staging` schema.
   - Example: `geolocation.sql`, `customers.sql`.

2. **Analytics Models:**
   - These models build a star schema for analysis.
   - Example: `orders.sql`, `sellers.sql`.

3. **ML Models (NLP on Reviews):**
   - This model applies NLP to the `order_reviews` table to extract insights from customer reviews.
   - Example: `order_reviews_nlp.sql`:

### Step 4: Running DBT Models

1. **Install Dependencies:**

```bash
dbt deps
```

2. **Run the Models:**

```bash
dbt run
```

## Conclusion

This project provides an end-to-end data warehouse solution using Snowflake and dbt. It ingests raw data, applies transformations, and creates clean, analytics-ready data. It can be extended with additional transformations, analytics, or machine learning models to gain further insights.

Feel free to modify and expand the project!

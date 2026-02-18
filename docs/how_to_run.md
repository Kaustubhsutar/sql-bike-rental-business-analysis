## ▶️ How to Reproduce This Analysis

Follow the steps below to replicate the project in **Google BigQuery**:

---

### Step 1: Open BigQuery

- Go to **Google Cloud Console**
- Navigate to **BigQuery**

---

### Step 2: Create a Dataset

- Click on your project name (left panel)
- Click **Create Dataset**
- Enter a Dataset ID (e.g., `bike_rental_dataset`)
- Select data location
- Click **Create Dataset**

---

### Step 3: Upload CSV Files as Tables

For each CSV file (`rides.csv`, `users.csv`, `stations.csv`):

- Click **Create Table**
- Under **Source**, choose:
  - **Create table from**: Upload
  - Select the CSV file
- Under **Destination**:
  - Choose your dataset
  - Enter a table name
- Under **Schema**:
  - Select **Auto-detect**
- Click **Advanced Options**:
  - Set **Header rows to skip = 1**
- Click **Create Table**

Repeat this process for all three CSV files.

---

### Step 4: Run the Analysis Script

- Open the `bike_rental_analysis_script.sql` file
- Copy the SQL code into BigQuery Query Editor
- Run the queries to generate insights

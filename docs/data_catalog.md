# 1. dbo.users

**Purpose**: Stores user-level information including demographic and registration details.
| Column Name       | Data Type    | Description                                                        |
| ----------------- | ------------ | ------------------------------------------------------------------ |
| user_id           | INT          | Unique identifier assigned to each user.                           |
| user_type         | NVARCHAR(50) | Indicates whether the user is a 'Casual' or 'Registered' customer. |
| gender            | NVARCHAR(20) | Gender of the user (e.g., Male, Female, Unknown).                  |
| birth_year        | INT          | Year of birth of the user.                                         |
| registration_date | DATE         | Date when the user registered in the system.                       |

# 2. dbo.stations

**Purpose**: Stores information about bike stations including geographic and operational details.
| Column Name  | Data Type     | Description                                                 |
| ------------ | ------------- | ----------------------------------------------------------- |
| station_id   | INT           | Unique identifier assigned to each station.                 |
| station_name | NVARCHAR(100) | Name of the bike station.                                   |
| city         | NVARCHAR(50)  | City where the station is located.                          |
| latitude     | DECIMAL(9,6)  | Geographic latitude coordinate of the station.              |
| longitude    | DECIMAL(9,6)  | Geographic longitude coordinate of the station.             |
| install_date | DATE          | Date when the station was installed and became operational. |

# 3. dbo.rides

**Purpose**: Stores transactional bike rental data for analytical and reporting purposes.
| Column Name       | Data Type     | Description                                                           |
| ----------------- | ------------- | --------------------------------------------------------------------- |
| ride_id           | INT           | Unique identifier for each ride transaction.                          |
| user_id           | INT           | Foreign key linking the ride to the users table.                      |
| start_station_id  | INT           | Foreign key referencing the station where the ride started.           |
| end_station_id    | INT           | Foreign key referencing the station where the ride ended.             |
| start_time        | DATETIME      | Date and time when the ride began.                                    |
| end_time          | DATETIME      | Date and time when the ride ended.                                    |
| ride_duration_min | INT           | Duration of the ride measured in minutes.                             |
| season            | NVARCHAR(20)  | Season during which the ride occurred (Spring, Summer, Fall, Winter). |
| weather_condition | NVARCHAR(50)  | Weather conditions at the time of the ride.                           |
| temperature       | DECIMAL(5,2)  | Temperature recorded during the ride (in Celsius).                    |
| rental_count      | INT           | Number of bikes rented (typically 1 per ride).                        |
| revenue           | DECIMAL(10,2) | Total revenue generated from the ride transaction.                    |

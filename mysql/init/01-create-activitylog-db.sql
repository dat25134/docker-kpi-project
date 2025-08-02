-- Create activitylog database
CREATE DATABASE IF NOT EXISTS activitylog CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Grant privileges to kpi_mysql user
GRANT ALL PRIVILEGES ON activitylog.* TO 'kpi_mysql'@'%';
FLUSH PRIVILEGES; 
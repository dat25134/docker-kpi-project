-- Create kpi database if not exists
CREATE DATABASE IF NOT EXISTS kpi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Grant privileges to kpi_mysql user
GRANT ALL PRIVILEGES ON kpi.* TO 'kpi_mysql'@'%';
FLUSH PRIVILEGES; 
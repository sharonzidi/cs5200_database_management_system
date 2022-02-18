# Download National data at: http://www.ssa.gov/oact/babynames/limits.html
# Specifically: http://www.ssa.gov/oact/babynames/names.zip
# Unzip it to a readable location.
# Copy data to a readable location. For example:
# $ mkdir /tmp/names
# $ cp ~/Downloads/names/yob2015.txt /tmp/names/
# $ cp ~/Downloads/names/yob2018.txt /tmp/names/


# Create the schema if necessary.
CREATE SCHEMA IF NOT EXISTS BabyNames;
USE BabyNames;

# Drop tables if necessary.
DROP TABLE IF EXISTS yob;
DROP TABLE IF EXISTS yob2018;
DROP TABLE IF EXISTS yob2015;

# Create tables if necessary.
CREATE TABLE yob2015 (
  Name VARCHAR(255),  # VARCHAR(15)
  Sex VARCHAR(6),  # VARCHAR(1)
  Number INT
  # CONSTRAINT pk_yob2015_name PRIMARY KEY (Name, Sex)
);

# Create tables if necessary.
CREATE TABLE yob2018 (
  Name VARCHAR(255),  # VARCHAR(15)
  Sex VARCHAR(6),  # VARCHAR(1)
  Number INT
  # CONSTRAINT pk_yob2018_name PRIMARY KEY (Name, Sex)
);


# Load the data.
LOAD DATA LOCAL INFILE 'Users/sharonxia/Documents/mysql/names/yob2015.txt' INTO TABLE yob2015
  FIELDS TERMINATED BY ','
  # Windows platforms may need '\r\n'.
  LINES TERMINATED BY '\n';

# Load the data.
LOAD DATA LOCAL INFILE 'Users/sharonxia/Documents/mysql/names/yob2018.txt' INTO TABLE yob2018
  FIELDS TERMINATED BY ','
  # Windows platforms may need '\r\n'.
  LINES TERMINATED BY '\n';


# Alternatively, create one table for all years.
CREATE TABLE yob (
  Name VARCHAR(255),
  Sex VARCHAR(6),
  Number INT,
  Year INT
);
# https://dev.mysql.com/doc/refman/5.7/en/load-data.html
LOAD DATA LOCAL INFILE 'Users/sharonxia/Documents/mysql/names/yob2015.txt' INTO TABLE yob
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n'
  (Name, Sex, Number)
  SET Year = 2015;
LOAD DATA INFILE 'Users/sharonxia/Documents/mysql/names/yob2018.txt' INTO TABLE yob
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n'
  (Name, Sex, Number)
  SET Year = 2018;


# Queries:
# Useful reference: http://dev.mysql.com/doc/refman/5.7/en/string-functions.html
# How many different baby names started with ‘Jae’ in 2015?
# String LIKE comparison is not case sensitive by default:
# https://dev.mysql.com/doc/refman/5.7/en/string-comparison-functions.html#operator_like
SELECT
  COUNT(Name)
  #COUNT(*)
  #Name, Sex, Number
FROM yob2015
WHERE Name LIKE 'Jae%';

# How many different baby boy names started with ‘Jae’ in 2015?
SELECT COUNT(*)
FROM yob2015
WHERE Sex = 'M'
  AND Name LIKE 'Jae%';

# How many different baby girl names started with ‘Lia’ in 2018?
SELECT COUNT(*)
# SELECT *
FROM yob2018
WHERE Sex = 'F'
  AND Name LIKE 'Lia%';
  #AND LEFT(Name, 3) = 'Lia;

# Which names have three or more e’s in 2018?
# String REGEXP is not case sensitive by default:
# https://dev.mysql.com/doc/refman/5.7/en/regexp.html#operator_regexp
SELECT *
FROM yob2018
WHERE
  Name REGEXP '(.*[e].*){3,}';

# Across multiple years, four or more e's.
SELECT *
FROM yob
WHERE Name REGEXP '(.*[e].*){4,}';

    
-- Drop the keyspace if it exists
DROP KEYSPACE IF EXISTS akili_pay;

-- Create our keyspace
CREATE KEYSPACE akili_pay WITH replication ={ 'class': 'SimpleStrategy', 'replication_factor': 2 };

-- Use the keyspace
USE akili_pay;

-- Table: employee
CREATE TABLE user(
   id int PRIMARY KEY,
   first_name text,
   surname text,
   account_id varint,
   address varint
);

    
-- Drop the keyspace if it exists
DROP KEYSPACE IF EXISTS akili_pocket;

-- Create our keyspace
CREATE KEYSPACE akili_pocket WITH replication ={ 'class': 'SimpleStrategy', 'replication_factor': 2 };

-- Use the keyspace
USE akili_pocket;

-- Table: employee
CREATE TABLE transactions(
   id int PRIMARY KEY,
   first_name text,
   surname text,
   account_id varint,
   address varint
);

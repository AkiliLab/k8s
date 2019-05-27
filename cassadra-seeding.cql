    
-- Drop the keyspace if it exists
DROP KEYSPACE IF EXISTS akili_pocket;

-- Create our keyspace
CREATE KEYSPACE akili_pocket WITH replication ={ 'class': 'SimpleStrategy', 'replication_factor': 2 };

-- Use the keyspace
USE akili_pocket;

-- Table: employee
CREATE TABLE transactions(
   id text PRIMARY KEY,
   description text,
   account_id text,
   created timestamp,
   amount varint,
   currency text,
   merchant text,
   notes text,
   settled timestamp,
   user_id text,
   is_load boolean,
   updated timestamp,
   local_amount varint,
   local_currency text
);

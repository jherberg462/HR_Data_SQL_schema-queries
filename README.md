# SQL queries for HR data

In this project, I created a schema for Human Resources ("HR") related data, so that said data can be imported into a SQL database. I also created various SQL queries that return information that someone working in HR may need in order to perform their job functions. 

## Schema

My schema created tables and columns within those tables that matched the data I was provided. I added constraints to each column that matches the data type contained in the dataset. To ensure data integrity, I also added foreign key constraints to columns with a one-to-many relationship with a primary key column of another table. 

## SQL queries

I drafted several queries that will return information that a HR professional may need to perform their job functions. My queries utilized left joins on primary key-foreigh key relationships between tables, sub queries to filter information I am intending to be returned, aliases to make writing the queries more concise. My queries also used regex to return information that matches regression input, ordering to display information deemed important first, and counts of column values. 

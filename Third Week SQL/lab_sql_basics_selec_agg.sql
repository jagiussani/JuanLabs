###################################################################################
################ Lab | SQL basics (selection and aggregation) #####################
###################################################################################

USE bank;

###### Query 1 #####
# Get the id values of the first 5 clients from district_id with a value equal to 1.
SELECT client_id FROM client
ORDER BY district_id, client_id ASC
LIMIT 5;

###### Query 2 #####
# In the client table, get an id value of the last client where the district_id is equal to 72.
SELECT client_id FROM client
WHERE district_id = 72
ORDER BY district_id, client_id DESC
LIMIT 1; 

###### Query 3 #####
# Get the 3 lowest amounts in the loan table.
SELECT amount FROM loan
ORDER BY amount ASC
LIMIT 3;

###### Query 4 #####
# What are the possible values for status, ordered alphabetically in ascending order in the loan table?
SELECT DISTINCT status FROM loan
ORDER BY status;

###### Query 5 #####
# What is the loan_id of the highest payment received in the loan table?
SELECT loan_id FROM loan
ORDER BY amount DESC
LIMIT 1;

###### Query 6 #####
# What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
SELECT account_id, amount FROM loan
ORDER BY account_id, amount
LIMIT 5;

####### Query 7 #####
# What are the top 5 account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
SELECT account_id FROM loan
WHERE duration = 60
ORDER BY amount
LIMIT 5;

####### Query 8 #####
# What are the unique values of k_symbol in the order table?

# Note: There shouldn't be a table name order, 
# since order is reserved from the ORDER BY clause. 
# You have to use backticks to escape the order table name.

SELECT DISTINCT (k_symbol) FROM `order`;

####### Query 9 #####
# In the order table, what are the order_ids of the client with the account_id 34?
SELECT order_id FROM `order`
WHERE account_id = 34

####### Query 10 #####
# In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
SELECT order_id, account_id FROM `order`
WHERE  29540 => order_id => 29560; 



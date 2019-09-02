# 2nd Sept, 2019

### To Run the Application:

1. Checkout and pull **Patched** branch.
2. Update procedure **Sp_GetItems** using the latest query in **Sp_GetItems.sql** file.
3. Update application codebase from this branch.
4. Run.

_______________________________________________________________



# 29th Aug, 2019

### To Run the Application:

1. Checkout the codebase from **patched** branch.
2. Run ***Sp_GetItems.sql*** in the root of this repo, to add this new procedure to database.


### To Test:

1. **/SalesInvoice** screen : GetItems performance with as much data as can be made available - to simulate high-traffic scenario. 
2. Since Hangfire has been disabled completely on this branch, testing is required to find any related side effects. Someone with domain knowledge should thoroughly look into this. 


#### Thanks.

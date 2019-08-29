### To Run the Application:

1. Checkout the codebase from **patched** branch.
2. Run ***Sp_GetItems.sql*** in the root of this repo, to add this new procedure to database.


### To Test:

1. **/SalesInvoice** screen : GetItems performance with as much data as can be made available - to simulate high-traffic scenario. 
2. Since Hangfire has been disabled completely on this branch, testing is required to find any related side effects. Someone with domain knowledge should thoroughly look into this. 


#### Thanks.

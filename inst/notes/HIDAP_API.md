# HIDAP 

## as a REST service

Use case: complement a database. User has navigated to a dataset and wants to do something with it elsewehere using HIDAP. The database just needs to know how to locate or call the HIDAP app; any further parameters should be set from within the HIDAP app.

- call HIDAP from within another web-page using a link; 
- the call will just transfer id of dataset such that the receiving HIDAP app can
   use it to retrieve the data using BRAPI
   
- BRAPI itself cannot right now be used to call an app unless we add it.
- one format idea:

localhost:4242/hidap/                 returns list of HIDAP apps
localhost:4242/hidap/locations        shows locations view
localhost:4242/hidap/locations/id     shows profile data for one location

## as addin for RStudio

Use case:
intermediate to advanced user(breeder/statistician) who wants to do more than standard analyses with breeding data.

- user can use it to interact both with BRAPI compliant database
- as well as use HIDAP for standard analyses to compare with own
- can easily use data to do other analyses 


## as self contained web app

Use case: breeder/user just wants to do quick standard analyses; does not want to install tools locally.




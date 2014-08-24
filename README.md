DS_Data_Products_Project
========================

Data Science - Data Products Project - Shiny App

# Description

The following application was developed for the Cousera Data Science, Data Products class.  

I work as a performance engineer for a major utility.  Our group is responsible for 
testing any new or major releases to the application software that is used by the utility.
We use automated tools to simulate the workload on the application using "virtual users" 
to represent the real users.  

A common test for our group to perform is a load test.  Using virtual users (vUser) we generate a simulated load on the "system under test."  The simulated load is intended to replicate the major user interactions with the application, or business functions.  An application may have 100's of unique functions, however, there is always a small number of functions that are used most frequently.  This smaller set of business functions are what we use to define the workload for the load tests.

The workload is a collection of business functions that represent 70-80% of the "load" on the application/"system under test".  The workload definition also includes information about the frequency that each functions is perform by each user type, the types of users, the number of "potential" users, and the number of concurrent users during the "peak hour."  This information is used establish scenarios for load testing the application. 

To setup a simulation a single user's interactions with the application are recorded or scripted.  A single business function may have 5-10 steps or unique transactions that require a specific interaction with the application.  Each script is then parameterized with data to make each user interaction unique.  For example a login script would be parameterized with different userid/password combinations.  

After the business functions are scripted and parameterized these scripts are incorporated into scenarios.  The scenario takes into account the number of users, the frequency that users enter the system, the think time between transactions, and pacing of business functions, and the mix of business functions.  The objective of the scenario is to replicate as closely as possible the "real world" use of the application.

A test "passes" when the 90th percentile response time for each transaction is with in the defined non-functional requirement for performance, and there is less then 5% of all transactions fail during the test period.

# Function

The list of functions that will be provided by the app:

* Data import: << DUE TO COMPLICATIONS WITH RUNNING ON A SHARED SERVER I ELECTED TO USE ONE DATASET IMBEDED IN THE CODE >>
* Report the raw data and summary stats for the tests
* Trim outliers from the raw data
* Generate diagnostic plots for each transaction:
    + Distribution of all data
    + Distribution of trimmed data
    + Time series of when the transactions occurred during the test, highlighting the "trimmed" data points.
    + Transaction per sample period.
   
# Documentation

## Inputs

* Select a specific to filter all the data in the reports
* Trim Outliers:
    + Low, defaults at bottom 5%
    + High, defaults at top 5%

## Input File Formats
The input file format is:

1. row_num: a sequence number
2. scenario_elasped_time: the time in the test when the transaction started.
3. trans_resp_time:  the duration of the transaction
4. trans_name: the name of the transaction

## Report Definition

### Raw Data
The report on this tab shows all the raw transaction data collected during the test.  This list can be filtered by transaction and/or sorted by the collected metrics.

Metrics Collected:

1. scenario_elasped_time: the time in the test when the transaction started.
3. trans_resp_time:  the duration of the transaction
4. trans_name: the name of the transaction
5. trans_end_time: calculated using a POSIX start date, adding the scenario_elapsed_time and the transction response time
6. trans_start_time: calculated using a POSIX start date, adding the scenario_elapsed_time

### Summary

The raw data is trimmed and compared to the full data.  This list can be filtered and sorted by the summary stats

### Transaction

Diagnostic Plots:

   - Distribution of all data
   - Distribution of trimmed data
   - Time series of when the transactions occurred during the test, highlighting the "trimmed" data points.
   - Transaction per sample period.



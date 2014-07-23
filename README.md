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

To setup a simulation the user interactions with the application are recorded or scripted.  A single business function may have 5-10 steps or unique transations that require a specific interaction with the application.  Each script is then parameterized with data to make each user interaction unique.  For example a login script would be parameterized with different userid/password combinations.  

After the business functions are scripted and parameterized these scripts are incorporated into scenario.  The scenario takes into account the number of users, the frequency that users enter the system, the think time between transactions, and pacing of business functions, and the mix of business functions.  The objective of the scenario is to replicate as closely as possible the "real world" use of the application.

The purpose of this tool is to analyze the resulting data collected during the test was successfully replicating the real world.  While there is no "real" world there are certain characteristics that a good test should include:
- Response times for transactions on a server with resources available or headroom, the transaction times should approximate normal.
- Responsee times for transactions on a server with resource constraints would have an expontial distribution.
- Transaction arrivals are Posion with a mean and lambda of ???
- Time between arrivals is a Negative Exponetial.
- Transaction action arrival are uniformly distributed through out the duration of the test.
- 90th Percentile response times must a prior agreed to service level agreement.

# Function

The list of functions that will be provided by the app

- Data import: Select the data from a load test for import into the application

- Report the summary stats for the tests

- Trim/Transform the data

- Plot the data:

   - All the data
   - Per transaction plots
   

# Documentation

## Input File Formats

## Report Definition
Not sure I need this, but this may be step-by-step documentation.


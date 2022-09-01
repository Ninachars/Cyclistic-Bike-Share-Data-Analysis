# Cyclistic Bike Share Data Analysis
#### Author: Nnenna Okereke
#### Date: 1st September 2022

*Description: This is a capstone project. I Carried out a data analysis using SQL and Tableau for visualisation on the Cyclistic Bike Share data from the Google Data Analytics Certificate on Coursera*

[Click here](https://public.tableau.com/app/profile/nnenna.okereke/viz/CyclisticBikeShare_16619498512940/Dashboard12?publish=yes) for the Tableau Visualization
___

## Introduction
Cyclistic runs a successful bike-share program in Chicago. Since its launch in 2016, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across the state. The bikes can be unlocked from one station and returned to any other station in the system anytime. The financial specialists at Cyclistic have determined that annual members are significantly more profitable than casual riders. Thus, increasing the number of annual members will be crucial to Cyclistic's future growth even though the pricing flexibility helps the company gain more clients. The Marketing director has a specific objective: Create marketing plans that will persuade occasional riders to become yearly subscribers. However, to achieve that, the marketing analyst team must have a deeper understanding of the distinctions between annual members and casual riders, the factors that cause casual riders to purchase memberships, and the potential impact of digital media on their marketing strategies. 
___

## Problem Statement
This analysis aims to evaluate how annual members and casual riders differ especially in their usage of the Cyclistic bike program using the trends from the Cyclistic historical bike trip data.
___

## Prepare
A 12-month historical data from August 2021 to July 2022 was used for the analysis and can be found [here](https://divvy-tripdata.s3.amazonaws.com/index.html). The data has been made available to the public by Motivate International Inc thus can be said to be credible.
___

## Process
In the "Process" stage of data analysis, it is necessary to decide which tool to use, check for errors, transform the data via data cleaning. SQL Server was the tool chosen for this analysis due to the size of the data. The total rows in the raw data were over 5.9 million rows. This is too big to be handled by spreadsheets thus the choice of SQL. Below, I will outline the steps taken to process the data:

* Loaded the 12 csv files into the SQL Server database as tables
* Verified that the number of columns and their corresponding data types across the 12 files were valid and consistent.
* Merged all the tables using the UNION ALL command into one large table containing all information of the bike rides from August 2021 to July 2022. This process can be found [here](https://github.com/Ninachars/Cyclistic-Bike-Share-Data-Analysis/blob/main/SQL%20Code/Data_Merging.sql)
* Performed an extensive data validation and cleaning which can be found [here](https://github.com/Ninachars/Cyclistic-Bike-Share-Data-Analysis/blob/main/SQL%20Code/Data_Validation_Cleaning.sql)

## Analyze
During this data analysis phase, It was key to ensure proper formatting of all data, create summary statistics of the data and perform some calculations. First, I extracted, calculated and updated the table with the columns: day_of_week, month, year, ride_duration and ride_route. In order to tackle the business problem, here are some necessary questions needed to be answered during the data exploration/analysis.

* What is the number of rides made by the casual users vs the annual members?
* Which trip had the longest duration?
* Using the average trip duration by user type, which segment takes longer or shorter trips?
* What bike type do the casual and annual member prefer?
* How does the ride activities vary over a time series of month, day of the week and hour of the day.
* Which stations are the most popular
* Which routes are the most popular?

The detailed SQL code for this data exploration can be found [here](https://github.com/Ninachars/Cyclistic-Bike-Share-Data-Analysis/blob/main/SQL%20Code/Data_Analysis.sql) and the resulting SQL [reports](https://github.com/Ninachars/Cyclistic-Bike-Share-Data-Analysis/tree/main/SQL%20Report) which was finally used for visualization can be found here.
___

## Share
I created a [tableau dashboard](https://public.tableau.com/app/profile/nnenna.okereke/viz/CyclisticBikeShare_16619498512940/Dashboard12?publish=yes) showing key findings which are summarised below:
* The rides by annual members make up 57.82% of the total rides while casual rides were 42.18%.
* The data indicates that casual users make longer trips.
* The annual members prefers the classic bikes and no rides where made using the docked bike by the annual members.
* There is a significant peak of bikes usuage during the summer period. However, the annual members' rides remain consistently and significantly higher than that of casual rides through out the year. While the casual rides peak during the weekend, the members' rides remained high all through the week though more rides are observed during weekdays. The annual members have peak usage in the morning between 7am to 9am and 4pm to 6pm while the casual users' rides sees a steady increase from 8am and peaks at 5pm before reversing downwards. This would make sense as most annual members are likely those with regular 9-5 jobs.
* While the most popular station and route were identified, It was not possible to explain why it may help in identifying pecularities amongst the casual and annual members due to limited knowledge of these locations. This presents an opportunity for further investigation if a more robust data is presented. However, advertising can be focused on the top 20 popular stations.

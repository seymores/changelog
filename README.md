# README

Simple state server to collect status data (hence the project name 'changelog'.
Demo server [here](http://changelogdemo.seymores.com/statuses).

![Front page](https://raw.githubusercontent.com/seymores/changelog/master/public/screenshots/screen1.png)

## Setup & Deployment
Requires Rails 5.0.1 and built for Postgresql 9.5.

Please set production database information in `config/secrets.yml`.

## Upload CSV Data

Server will batch process the [uploaded](http://changelogdemo.seymores.com/statuses/upload) data from the csv file using [activerecord-import](https://github.com/zdennis/activerecord-import).
See sample data file [here](https://raw.githubusercontent.com/seymores/changelog/master/data.csv). 

## Status Query

User [can query](http://changelogdemo.seymores.com/statuses/query) for data by ID, type and timestamp.
JSON format result is available, see the special link at bottom right.

![Status query](https://raw.githubusercontent.com/seymores/changelog/master/public/screenshots/screen2.png)


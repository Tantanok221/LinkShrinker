# README

This is a link shortener website that shortened url and track analytic of the shortened url

### Installation Guide
Ruby version: 8.0.1

install dependencies & setup database
```
make install
```
Launch Dev Server
```
make dev
```
The dev server will launch at localhost:3000

### Deployment Guide
Each code that are push/merged to master will automatically deployed to the production instance(via railways ci/cd)

Production URL:  [Production Instances](https://linkshrinker-production.up.railway.app/)

### Tech Stacks
Frontend/Backend: Ruby on Rails with Turbowire  
Database: SQLite   
Cache: SQLite(solid cache)  

### Read More
More details related about this project are at /docs
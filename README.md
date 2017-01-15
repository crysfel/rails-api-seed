Rails API Seed
===========

This is a seed project to create a REST API using rails and mysql. It support login authentication using JWT, policies to handle authorization to resources,

Features
--------
**Endpoints**
* Sign up and login
* User management for admin only
* Asset manager for admin only

**Code**
* Amazon S3 file upload to handle assets
* JWT for authentication
* Pundit for policies and privileges

Running development
-------------------
Clone the project, rename the main folder to your awesome new ploject's name.

1. Install dependencies
`$ bundle`

2. Configure the database name and credentials
`$ vim config/database.yml`

3. Setup database
`$ rake db:create`
`$ rake db:migrate`

4. Run the dev server
`$ rails s`


Deployment instructions
-----------------------

# Mobile API README
=======================

# First Screen Verifying if user exist or create
	{BASE_URL}/api/v1/user/verify
	body params
	{ 
		username: "namehere"
	}
-----------------------

# Get all movies
	{BASE_URL}/api/v1/movie/
-----------------------

# Get specific movie detail
	{BASE_URL}/api/v1/movie/:movie_name
-----------------------

# Mark movie as favorite
	{BASE_URL}/api/v1/movie/:movie_id/favorite
	body params
	{
		"user_id": "id here"
	}
-----------------------

# Get list of favorite movies for a specific user 
	{BASE_URL}/api/v1/user/:user_id/favorite_movies
	body params
	{
		"user_id": "id here"
	}
-----------------------

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

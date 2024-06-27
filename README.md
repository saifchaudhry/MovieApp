# Mobile API README
=======================

# Deployed to heroku 
https://movieapp3.herokuapp.com/admin

# BASE_URL
https://movieapp3.herokuapp.com/

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

# Screencast video for admin
https://www.screencast.com/t/D9y6RT6Mi7

#Embeddable Build Status Icon
[![Build Status](http://159.223.184.183:8080/job/TestRspec/badge/icon)](http://159.223.184.183:8080/job/TestRspec/)

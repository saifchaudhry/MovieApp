require 'rails_helper'

RSpec.describe "Movies", type: :request do
	# initialize test data
	let!(:user) { User.create(username: "testuser") }
  let!(:movie1) { Movie.create(name: "James Bond", genres: ["Action"], year: "2021")}
  let!(:movie2) { Movie.create(name: "Transporte", genres: ["Action"], year: "2020")}
  # Test suite for GET /movies
  describe 'GET /movies' do
    # make HTTP get request before each example
    before { get "/api/v1/movie/" }

    it 'returns movies' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET specific movie' do
    # make HTTP get request before each example
    before { get "/api/v1/movie/#{movie2.name}" }

    it 'returns specific movie' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json["name"]).to eq("Transporte")
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    
  end

  describe 'GET specific movie' do
    # make HTTP get request before each example
    before { get URI.escape("/api/v1/movie/#{movie1.name}") }

    it 'returns specific movie' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json["name"]).to eq("James Bond")
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    
  end

  describe 'GET specific movie by invalid name' do
    # make HTTP get request before each example
    before { get URI.escape("/api/v1/movie/nonexisting") }

    it 'returns error' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json["message"]).to eq("No movie is found by this name")
    end

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
    
  end

  describe 'POST /movie' do

    context 'mark movie as favorite' do
      before { post "/api/v1/movie/#{movie1.id}/favorite", params: {user_id: user.id} }

      it 'favorite a movie' do
        expect(json["favorited"]).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'show error for invalid' do
      before { post "/api/v1/movie/#{3}/favorite", params: {user_id: user.id} }

      it 'favorite a movie' do
        expect(json["message"]).to eq("Movie or User not found")
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end


end

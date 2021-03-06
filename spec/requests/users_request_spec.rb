require 'rails_helper'

RSpec.describe "Users", type: :request do
	# initialize test data
	let!(:user) { User.create(username: "testuser") }
  let!(:movie1) { Movie.create(name: "James Bond", genres: ["Action"], year: "2021")}
  let!(:movie2) { Movie.create(name: "Transporte", genres: ["Action"], year: "2020")}
  # Test suite for GET /users
  describe 'GET /users' do
    # make HTTP get request before each example
    before { get "/api/v1/user/#{user.id}/favorite_movies" }

    it 'returns user favorite movies' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json["message"]).to eq("No movie favorited by this user")
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    context 'when movie is favorited' do
      let(:favorite) { Favorite.create(user_id: user.id, movie_id: movie1.id) }
      it 'returns favorite movie' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

    # Test suite for POST /users
  describe 'POST /users' do
    # valid payload
    let(:valid_username) { { username: 'test' } }
    let(:valid_username1) { { username: 'test1' } }
    let(:valid_username2) { {username: 'test_1' } }

    context 'when the username is valid alphabets' do
      before { post '/api/v1/user/verify', params: valid_username }

      it 'creates a user' do
        expect(json.size).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the username is valid alphanumeric' do
      before { post '/api/v1/user/verify', params: valid_username }

      it 'creates a user' do
        expect(json.size).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the username is valid alphanumeric and underscore' do
      before { post '/api/v1/user/verify', params: valid_username }

      it 'creates a user' do
        expect(json.size).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/user/verify', params: { username: "mylenghtisgreaterthan20" } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(json["status"]).to eq("failure")
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/user/verify', params: { username: "Imcontaining@" } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(json["status"]).to eq("failure")
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/user/verify', params: { username: "Imcontaining." } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(json["status"]).to eq("failure")
      end
    end

  end

end

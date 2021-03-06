module Movies
  module ErrorFormatter
    def self.call(message, backtrace, options, env, er)
        { :status => 'failure', :reason => message }.to_json
    end
  end
  class API < Grape::API
    version 'v1', using: :header, vendor: 'movie'
    format :json
    prefix :"api/v1"
    error_formatter :json, ErrorFormatter

    resource :user do

      desc 'verify a user'
      params do
        requires :username, type: String
      end
      post :verify do
        @user = User.find_or_initialize_by(params)
        if !@user.validate && @user.errors.any?
          error!({ status: 'failure', reason: @user.errors.full_messages } , 400)
        elsif @user.new_record? && @user.save
          status 201
          { message: "New User is created" }
        else
          status 200
          { message: "User already exist" }
        end
      end

      desc 'Get favorites movie of specific user'
      route_param :id do
        get :favorite_movies do
          @user = ::User.find_by_id(params[:id])
          if @user.nil?
            status 404
            { message: "User not found" }
          else
            @user.favorite_movies.any? ? @user.favorite_movies : {message: "No movie favorited by this user"}
          end
        end
      end

    end

    resource :movie do

      desc 'Get all movies'
      get '/' do
        ::Movie.all
      end

      desc 'Get specific movie by name'
      get '/:name' do
        @movie = ::Movie.find_by(params)
        if @movie
          @movie
        else
          status 404
          { message: "No movie is found by this name" }
        end
      end

      desc 'Mark movie as favorite'
      params do
        requires :user_id, type: Integer
      end
      route_param :id do
        post :favorite do
          @movie = ::Movie.find_by_id(params[:id])
          @user = ::User.find_by_id(params[:user_id])
          if @movie && @user
            @user.favorites.find_or_create_by(movie_id: @movie.id)
            @movie.reload
          else
            status 404
            { message: "Movie or User not found" }
          end
        end
      end

    end
  end
end
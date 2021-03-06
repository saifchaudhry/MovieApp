RailsAdmin.config do |config|

  ### Popular gems integration

  config.authorize_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      username == "test" &&
      password == "password"
    end
  end
  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.model 'Movie' do
    list do
      field :name
      field :year
      field :favorited
    end

    edit do
      field :name
      field :genres, :enum do
        enum do
          Movie::GENRES
        end
        multiple do
          true
        end
      end
      field :year do
        partial "date_field"
      end
      field :main_star
      field :description
      field :director
      exclude_fields :favorites
    end

  end

  config.model 'User' do

    configure :preview do
      pretty_value do
        user = bindings[:object]
        %{ #{user.favorite_movies.count} }
      end
    end

    list do
      field :username
      field :preview
    end

    show do
      field :username
      field :favorite_movies
    end

  end
  config.excluded_models << 'Favorite'



  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['User']
    end
    show
    edit do
      except ['User']
    end
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end

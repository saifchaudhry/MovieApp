class Favorite < ApplicationRecord

	belongs_to :user
	belongs_to :movie
	validates_presence_of :movie_id, :user_id
	validates_uniqueness_of :movie_id, :scope => [:user_id]
	after_create :update_movie_favorite_count

	def update_movie_favorite_count
		m = movie
		m.favorited +=1
		m.save(validate: false)
	end

end

class Movie < ApplicationRecord

	GENRES=["Action", "Adventure","Animation", "Biograpgy", "Comedy", "Crime", "Documentary", "Drama" ,"Fantasy", "History", "Horror" ,"Musical" ,"Mystery" ,"Romance" ,"Sci-Fi" ,"Thriller" ,"War", "Western"]

	before_validation :remove_empty_strings, if: -> { genres.present? }
	validates_presence_of :name, :genres, :year, :favorited
	validates_length_of :year, is: 4
	validate :validate_genres, if: -> { genres.present? }

	has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  def remove_empty_strings
  	self.genres = self.genres.compact.reject(&:empty?)
  end

  def validate_genres
  	genres.each do |genre|
  		errors.add(:genres, "Genre is invalid.") unless GENRES.include?(genre)
  	end
  end

end

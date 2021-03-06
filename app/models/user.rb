class User < ApplicationRecord

	validates :username,
    :presence => true,
    :uniqueness => true,
    :username_convention => true
  validates :username, length: { :maximum => 20 }

  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, :source => :movie

end

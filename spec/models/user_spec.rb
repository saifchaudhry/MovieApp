require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:favorites).dependent(:destroy) }
  it { should have_many(:favorite_movies).through(:favorites) }
  # Validation tests 
  # ensure columns username is present and unique

  
  it { should validate_presence_of(:username) }

  subject { FactoryBot.build(:user) }
  it { should validate_uniqueness_of(:username) }
end

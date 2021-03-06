require 'rails_helper'

RSpec.describe Movie, type: :model do
  # Association test
  it { should have_many(:favorites).dependent(:destroy) }
  it { should have_many(:favorited_by).through(:favorites) }
  # Validation tests
  # ensure columns username is present and unique
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:genres) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:favorited) }
  it { should validate_length_of(:year) }
end

class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
    	t.string :name, null: false, limit: 80
      t.string :genres, array: true, default: []
      t.string :year
      t.string :director, limit: 60
      t.string :main_star, limit: 60
      t.text :description, limit: 400
      t.integer :favorited, default: 0
      t.timestamps
    end
  end
end

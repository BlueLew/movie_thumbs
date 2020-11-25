class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :thumbs_up
      t.integer :thumbs_down

      t.timestamps
    end
  end
end

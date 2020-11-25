class AddAttributesToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :director, :string
    add_column :movies, :release_date, :date
    add_column :movies, :plot, :text
    add_column :movies, :poster, :string
  end
end

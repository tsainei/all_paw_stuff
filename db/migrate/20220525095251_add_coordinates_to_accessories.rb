class AddCoordinatesToAccessories < ActiveRecord::Migration[6.1]
  def change
    add_column :accessories, :latitude, :float
    add_column :accessories, :longitude, :float
  end
end

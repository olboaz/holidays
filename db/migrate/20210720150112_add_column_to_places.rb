class AddColumnToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :email, :string
  end
end

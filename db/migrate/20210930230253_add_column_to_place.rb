class AddColumnToPlace < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :upc, :string
  end
end

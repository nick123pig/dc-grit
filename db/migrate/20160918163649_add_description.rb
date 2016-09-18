class AddDescription < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :description, :float
  end
end

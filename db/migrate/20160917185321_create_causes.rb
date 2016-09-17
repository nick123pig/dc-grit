class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :location, null: false
      t.belongs_to :user, null: false, index: true
      t.timestamps
    end
  end
end

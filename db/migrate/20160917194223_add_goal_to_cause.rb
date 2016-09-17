class AddGoalToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :goal_amount, :decimal, :precision => 8, :scale => 2, null: false, default: 0.00
  end
end

class CreateUserPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :user_payments do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :cause, null: false, index: true
      t.string :stripe_charge_id, null: false
      t.decimal :amount, :precision => 8, :scale => 2
      t.timestamps
    end
  end
end

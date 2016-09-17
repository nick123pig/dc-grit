# == Schema Information
#
# Table name: user_payments
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  stripe_charge_id :string           not null
#  amount           :decimal(8, 2)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class UserPayment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :project, presence: true
  validates :user, presence: true
  validates :stripe_charge_id, presence: true
  validates :amount, presence: true
  validates :amount, numericality: true

end

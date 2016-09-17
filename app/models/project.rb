# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  location    :text             not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  goal_amount :decimal(8, 2)    default(0.0), not null
#

class Project < ApplicationRecord
  belongs_to :user
  has_many :user_payments

  validates :title, presence: true
  validates :location, presence: true
  validates :user, presence: true

  def money_raised
    self.user_payments.sum(:amount)
  end

  def money_raised_formatted
    Money.new(money_raised, "USD").format
  end

end
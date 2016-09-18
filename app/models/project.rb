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

  def progress_to_goal
    if money_raised >= goal_amount
      "100"
    else
      (money_raised / self.goal_amount * 100).to_i.to_s
    end
  end

  def goal_amount_formatted
    Money.new(self.goal_amount * 100 , "USD").format
  end

  def money_raised
    self.user_payments.sum(:amount)
  end

  def money_raised_formatted
    Money.new(money_raised * 100, "USD").format
  end

  def average_contribution
    self.user_payments.average(:amount) || 0
  end

  def average_contribution_formatted
    Money.new(average_contribution * 100, "USD").format
  end

  def backed_by_string
    "#{self.user_payments.count} people have backed with an average amount of #{average_contribution_formatted}"
  end

end

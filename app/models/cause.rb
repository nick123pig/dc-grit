class Cause < ApplicationRecord
  belongs_to :user
  has_many :user_payments
end

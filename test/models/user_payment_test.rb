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

require 'test_helper'

class UserPaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

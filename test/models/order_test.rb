require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  total           :integer
#  user_id         :integer
#  item            :string
#  billing_name    :string
#  billing_address :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

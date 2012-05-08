require 'test_helper'

class InvestmentControllerTest < ActionController::TestCase
  test "should get buy" do
    get :buy
    assert_response :success
  end

  test "should get sell" do
    get :sell
    assert_response :success
  end

end

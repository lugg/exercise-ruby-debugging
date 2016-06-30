require 'test_helper'

class MovesControllerTest < ActionController::TestCase
  test "saves the move+address" do
    post :create, description: "Sectional sofa", address: "487 Bryant St"
    assert_response :success
    move = Move.find(last_json[:id])
    assert_equal "Sectional sofa", move.description
    assert_equal 487, move.address.number
    assert_equal "Bryant St", move.address.street
    assert_equal "San Francisco", move.address.city
    assert_equal "CA", move.address.state
    assert_equal "United States", move.address.country
  end

  test "makes a request to dispatch the move" do
    post :create, description: "Sectional sofa", address: "487 Bryant St"
    assert_response :success
    assert_requested :post, 'https://onfleet.com/api/v2/tasks'
  end

  test "weird dispatch failure" do
    # not sure why our Onfleet stub is rejecting this address:
    post :create, description: "Sectional sofa", address: "9 Hilgard Way"
    assert_response :success
  end

  private

  def last_json
    @last_json ||= MultiJson.decode(response.body).with_indifferent_access
  end
end

require 'test_helper'

class FollowsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    sign_in users(:me)
    @follow = follows(:chris)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:follows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create follow" do
    assert_difference('Follow.count') do
      post :create, follow: { name: @follow.name }
    end

    assert_redirected_to follow_path(assigns(:follow))
  end

  test 'unverified user may not create a follow' do
    sign_out users(:me)
    assert_no_difference('Follow.count') do
      post :create, follow: { name: @follow.name }
    end
  end

  test "should show follow" do
    get :show, id: @follow
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @follow
    assert_response :success
  end

  test "should update follow" do
    patch :update, id: @follow, follow: { name: @follow.name }
    assert_redirected_to follow_path(assigns(:follow))
  end

  test "should destroy follow" do
    assert_difference('Follow.count', -1) do
      delete :destroy, id: @follow
    end

    assert_redirected_to follows_path
  end

  test 'unverified users may not destroy follow' do
    sign_out users(:me)
    assert_no_difference('Follow.count', -1) do
      delete :destroy, id: @follow
    end
  end
end

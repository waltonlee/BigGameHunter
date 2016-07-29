require 'test_helper'

class GametypesControllerTest < ActionController::TestCase
  setup do
    @gametype = gametypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gametypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gametype" do
    assert_difference('Gametype.count') do
      post :create, gametype: { category: @gametype.category, image: @gametype.image, name: @gametype.name }
    end

    assert_redirected_to gametype_path(assigns(:gametype))
  end

  test "should show gametype" do
    get :show, id: @gametype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gametype
    assert_response :success
  end

  test "should update gametype" do
    patch :update, id: @gametype, gametype: { category: @gametype.category, image: @gametype.image, name: @gametype.name }
    assert_redirected_to gametype_path(assigns(:gametype))
  end

  test "should destroy gametype" do
    assert_difference('Gametype.count', -1) do
      delete :destroy, id: @gametype
    end

    assert_redirected_to gametypes_path
  end
end

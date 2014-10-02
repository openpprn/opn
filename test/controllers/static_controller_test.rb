require 'test_helper.rb'

class StaticControllerTest < ActionController::TestCase

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get home" do
    # Research Questions need to be loaded into test fixtures first
    get :home
    assert_not_nil assigns(:pc)
    assert_not_nil assigns(:research_qs)
    assert_response :success
  end

  test "should get learn" do
    get :learn
    assert_not_nil assigns(:pc)
    assert_response :success
  end

  test "should get share" do
    get :share
    assert_not_nil assigns(:pc)
    assert_response :success
  end

  test "should get research" do
    get :research
    assert_not_nil assigns(:pc)
    assert_response :success
  end

  test "should get team" do
    get :team
    assert_not_nil assigns(:pc)
    assert_response :success
  end

  test "should get faqs" do
    get :faqs
    assert_not_nil assigns(:pc)
    assert_response :success
  end

end

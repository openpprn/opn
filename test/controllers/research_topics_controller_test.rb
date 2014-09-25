require 'test_helper'

class ResearchTopicsControllerTest < ActionController::TestCase
  test "User can view accepted research topics" do
    login(users(:user_1))

    get :index

    assert_response :success
    assert_equal ResearchTopic.accepted, assigns(:research_topics)
  end

  test "User can edit own research topic" do
    login(users(:user_2))

    get :edit, id: research_topics(:rt2)

    assert_response :success
    assert_equal assigns(:research_topic), research_topics(:rt2)
  end

  test "New" do
    login(users(:user_3))

    get :new

    assert_response :success
  end

  test "User can view accepted research topic" do
    login(users(:user_1))

    get :show, id: research_topics(:rt2).id

    assert_not_nil assigns(:research_topic)
    assert_response :success
  end


  test "User can create new research topic" do
    login(users(:user_2))

    assert_difference "ResearchTopic.count" do
      post :create, research_topic: {text: "Some new research topic", description: "Why I think this is important"}
    end

    assert_not_nil assigns(:research_topic)
    assert_equal "under_review", assigns(:research_topic).state
    assert_redirected_to research_topics_path
  end


  test "User can update own research topic" do
    login(users(:user_2))

    new_attrs = {text: "Updated text"}

    assert users(:user_2).can_update?(research_topics(:rt2))

    patch :update, research_topic: new_attrs, id: research_topics(:rt2).id

    research_topics(:rt2).reload

    assert_equal research_topics(:rt2), assigns(:research_topic)
    assert_equal research_topics(:rt2).text, new_attrs[:text]

    assert_redirected_to research_topic_path(assigns(:research_topic))


  end

  test "User cannot modify another user's research topic" do
    login(users(:user_1))

    old_text = research_topics(:rt2).text
    new_attrs = {text: "Updated text"}

    assert_not_equal old_text, new_attrs[:text]

    patch :update, research_topic: new_attrs, id: research_topics(:rt2).id

    research_topics(:rt2).reload

    assert_equal research_topics(:rt2).text, old_text

    assert_authorization_exception
  end

  test "User cannot change state of research topic" do
    login(users(:social))

    new_attrs = {state: "accepted"}

    patch :update, research_topic: new_attrs, id: research_topics(:rejected).id

    research_topics(:rejected).reload

    assert_equal research_topics(:rejected).state, "rejected"
  end

  test "User can view un-accepted research topic that they own" do
    login(users(:social))

    get :show, id: research_topics(:rejected).id

    assert_response :success
    assert_equal research_topics(:rejected), assigns(:research_topic)


  end

  test "User cannot view un-accepted research topic that they do not own" do

    login(users(:user_1))

    get :show, id: research_topics(:rejected).id


    assert_authorization_exception
  end

  test "Moderator can change state of a research topic" do
    login(users(:moderator_1))

    new_attrs = {state: "accepted"}

    patch :update, research_topic: new_attrs, id: research_topics(:rejected).id

    research_topics(:rejected).reload

    assert_equal research_topics(:rejected).state, new_attrs[:state]
  end

end
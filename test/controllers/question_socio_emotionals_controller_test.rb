require 'test_helper'

class QuestionSocioEmotionalsControllerTest < ActionController::TestCase
  setup do
    @question_socio_emotional = question_socio_emotionals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_socio_emotionals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_socio_emotional" do
    assert_difference('QuestionSocioEmotional.count') do
      post :create, question_socio_emotional: { creator_id: @question_socio_emotional.creator_id, data_final: @question_socio_emotional.data_final, user_id: @question_socio_emotional.user_id }
    end

    assert_redirected_to question_socio_emotional_path(assigns(:question_socio_emotional))
  end

  test "should show question_socio_emotional" do
    get :show, id: @question_socio_emotional
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_socio_emotional
    assert_response :success
  end

  test "should update question_socio_emotional" do
    patch :update, id: @question_socio_emotional, question_socio_emotional: { creator_id: @question_socio_emotional.creator_id, data_final: @question_socio_emotional.data_final, user_id: @question_socio_emotional.user_id }
    assert_redirected_to question_socio_emotional_path(assigns(:question_socio_emotional))
  end

  test "should destroy question_socio_emotional" do
    assert_difference('QuestionSocioEmotional.count', -1) do
      delete :destroy, id: @question_socio_emotional
    end

    assert_redirected_to question_socio_emotionals_path
  end
end

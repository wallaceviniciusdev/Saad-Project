require 'test_helper'

class ResultSocioEmotionalsControllerTest < ActionController::TestCase
  setup do
    @result_socio_emotional = result_socio_emotionals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:result_socio_emotionals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create result_socio_emotional" do
    assert_difference('ResultSocioEmotional.count') do
      post :create, result_socio_emotional: { aut_emoc: @result_socio_emotional.aut_emoc, cons_emoc: @result_socio_emotional.cons_emoc, cons_soc: @result_socio_emotional.cons_soc, cria_emoc: @result_socio_emotional.cria_emoc, question_socio_emotional_id: @result_socio_emotional.question_socio_emotional_id, reg_emoc: @result_socio_emotional.reg_emoc, user_id: @result_socio_emotional.user_id }
    end

    assert_redirected_to result_socio_emotional_path(assigns(:result_socio_emotional))
  end

  test "should show result_socio_emotional" do
    get :show, id: @result_socio_emotional
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @result_socio_emotional
    assert_response :success
  end

  test "should update result_socio_emotional" do
    patch :update, id: @result_socio_emotional, result_socio_emotional: { aut_emoc: @result_socio_emotional.aut_emoc, cons_emoc: @result_socio_emotional.cons_emoc, cons_soc: @result_socio_emotional.cons_soc, cria_emoc: @result_socio_emotional.cria_emoc, question_socio_emotional_id: @result_socio_emotional.question_socio_emotional_id, reg_emoc: @result_socio_emotional.reg_emoc, user_id: @result_socio_emotional.user_id }
    assert_redirected_to result_socio_emotional_path(assigns(:result_socio_emotional))
  end

  test "should destroy result_socio_emotional" do
    assert_difference('ResultSocioEmotional.count', -1) do
      delete :destroy, id: @result_socio_emotional
    end

    assert_redirected_to result_socio_emotionals_path
  end
end

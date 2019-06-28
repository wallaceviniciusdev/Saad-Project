require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  setup do
    @result = results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create result" do
    assert_difference('Result.count') do
      post :create, result: { au: @result.au, ch: @result.ch, data_final: @result.data_final, ec: @result.ec, gm: @result.gm, ls: @result.ls, quiz_id: @result.quiz_id, se: @result.se, student_id: @result.student_id, sv: @result.sv, tf: @result.tf }
    end

    assert_redirected_to result_path(assigns(:result))
  end

  test "should show result" do
    get :show, id: @result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @result
    assert_response :success
  end

  test "should update result" do
    patch :update, id: @result, result: { au: @result.au, ch: @result.ch, data_final: @result.data_final, ec: @result.ec, gm: @result.gm, ls: @result.ls, quiz_id: @result.quiz_id, se: @result.se, student_id: @result.student_id, sv: @result.sv, tf: @result.tf }
    assert_redirected_to result_path(assigns(:result))
  end

  test "should destroy result" do
    assert_difference('Result.count', -1) do
      delete :destroy, id: @result
    end

    assert_redirected_to results_path
  end
end

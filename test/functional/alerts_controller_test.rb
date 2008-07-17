require File.dirname(__FILE__) + '/../test_helper'

class AlertsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:alerts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_alert
    assert_difference('Alert.count') do
      post :create, :alert => { }
    end

    assert_redirected_to alert_path(assigns(:alert))
  end

  def test_should_show_alert
    get :show, :id => alerts(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => alerts(:one).id
    assert_response :success
  end

  def test_should_update_alert
    put :update, :id => alerts(:one).id, :alert => { }
    assert_redirected_to alert_path(assigns(:alert))
  end

  def test_should_destroy_alert
    assert_difference('Alert.count', -1) do
      delete :destroy, :id => alerts(:one).id
    end

    assert_redirected_to alerts_path
  end
end

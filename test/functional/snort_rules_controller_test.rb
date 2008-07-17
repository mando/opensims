require File.dirname(__FILE__) + '/../test_helper'

class SnortRulesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:snort_rules)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_snort_rule
    assert_difference('SnortRule.count') do
      post :create, :snort_rule => { }
    end

    assert_redirected_to snort_rule_path(assigns(:snort_rule))
  end

  def test_should_show_snort_rule
    get :show, :id => snort_rules(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => snort_rules(:one).id
    assert_response :success
  end

  def test_should_update_snort_rule
    put :update, :id => snort_rules(:one).id, :snort_rule => { }
    assert_redirected_to snort_rule_path(assigns(:snort_rule))
  end

  def test_should_destroy_snort_rule
    assert_difference('SnortRule.count', -1) do
      delete :destroy, :id => snort_rules(:one).id
    end

    assert_redirected_to snort_rules_path
  end
end

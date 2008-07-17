require File.dirname(__FILE__) + '/../test_helper'

class SnortRuleTypesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:snort_rule_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_snort_rule_type
    assert_difference('SnortRuleType.count') do
      post :create, :snort_rule_type => { }
    end

    assert_redirected_to snort_rule_type_path(assigns(:snort_rule_type))
  end

  def test_should_show_snort_rule_type
    get :show, :id => snort_rule_types(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => snort_rule_types(:one).id
    assert_response :success
  end

  def test_should_update_snort_rule_type
    put :update, :id => snort_rule_types(:one).id, :snort_rule_type => { }
    assert_redirected_to snort_rule_type_path(assigns(:snort_rule_type))
  end

  def test_should_destroy_snort_rule_type
    assert_difference('SnortRuleType.count', -1) do
      delete :destroy, :id => snort_rule_types(:one).id
    end

    assert_redirected_to snort_rule_types_path
  end
end

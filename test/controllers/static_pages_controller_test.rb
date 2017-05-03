require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest\

  def setup
    @base_setup = "Ruby on Rails Tutorial Sample App"
  end

  test "Root should be home" do
    get root_url
    assert_response :success
    assert_select "title", "#{@base_setup}"
  end
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_setup}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_setup}"

  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_setup}"

  end

  test "should get contacts" do
    get contacts_path
    assert_response :success
    assert_select "title", "Contact | #{@base_setup}"
  end
end

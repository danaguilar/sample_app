require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "layout links while logged out" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contacts_path
    assert_select "a[href=?]", login_path
    get contacts_path
    assert_select "title", full_title("Contact")
  end

  test "goto signup page" do
    get signup_path
    assert "title", full_title("Sign up")
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Daniel", email: "example@test.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ''
    assert_not  @user.valid?
  end

  test "email should be presense" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 255 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid email addresses" do
    valid_address = %w[example@test.com EiTHE_3e@another.com first.last@name.com weird-dashes-andThings@gmail.com]
    valid_address.each  do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid email addresses" do
    invalid_address = %w[example@test,com another.com This-one-sucks@gmail for@bar..com]
    invalid_address.each do |address|
      @user.email =  address
      assert_not @user.valid?, "#{address} should not be valid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "emails should be lower cased on save" do
    @user.email = 'TEST@EXAMPLE.COM'
    @user.save
    assert @user.reload.email == 'test@example.com'
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = ' '*6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = 'a'*5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with a nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
end

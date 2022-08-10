require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end
  
  test "should be valid" do
    assert @user.valid?
  end

  test "should be present" do 
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be presemt" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "mail should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email format is valid" do 
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    
    valid_addresses.each do | valid_address|
    @user.email = valid_address
    assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
    foo@bar_baz.com foo@bar+baz.com]
    
    invalid_addresses.each do |inv_addr|
        @user.email = inv_addr
        assert_not @user.valid?, "#{inv_addr.inspect} should be invalid."
    end
  end
end
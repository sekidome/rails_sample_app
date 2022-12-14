require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "Foobar123%", password_confirmation: "Foobar123%")
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
    foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    
    invalid_addresses.each do |inv_addr|
        @user.email = inv_addr
        assert_not @user.valid?, "#{inv_addr.inspect} should be invalid."
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password is long enough" do 
    assert @user.password.length >= 8
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test "password format is valid" do 
    valid_pws = %w[§15aR$67 Foobar123% Kkfh1oetj($&khf4 Hsfg45&§d]
    
    valid_pws.each do | valid_pw|
    @user.password = valid_pw
    @user.password_confirmation = valid_pw
    assert @user.valid?, "#{valid_pw.inspect} should be valid"
    end
  end

  test "password validation should reject invalid addresses" do
    invalid_pws = %w[aR$67 pwoerpzo LKADGEOG jdlgkwrlz235 awerpgj))§%
      §kg0% PSDG0$% 22222262f221G2412]
    
      invalid_pws.each do |invalid_pw|
        @user.password = invalid_pw
        @user.password_confirmation = invalid_pw
        assert_not @user.valid?, "#{invalid_pw.inspect} should be invalid."
    end
  end

end

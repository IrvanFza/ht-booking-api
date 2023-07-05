require "test_helper"

class GuestTest < ActiveSupport::TestCase
  def setup
    @guest = guests(:one)
  end

  test "guest should be valid" do
    assert @guest.valid?
  end

  test "first name should be present" do
    @guest.first_name = ""
    assert_not @guest.valid?
  end

  test "last name should not be more than 100 chars" do
    @guest.last_name = "a" * 101
    assert_not @guest.valid?
  end

  test "email should be present" do
    @guest.email = ""
    assert_not @guest.valid?
  end

  test "email should not be more than 100 chars" do
    @guest.email = "a" * 101 + "@domain.com"
    assert_not @guest.valid?
  end

  test "email should be unique and case insensitive" do
    duplicate_guest = @guest.dup
    duplicate_guest.email = @guest.email.upcase
    @guest.save
    assert_not duplicate_guest.valid?
  end

  test "phone number should not be more than 25 chars" do
    @guest.phone_number = "a" * 26
    assert_not @guest.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "JohnDoe@Domain.com"
    @guest.email = mixed_case_email
    @guest.save
    assert_equal mixed_case_email.downcase, @guest.reload.email
  end
end

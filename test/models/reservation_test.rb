require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  def setup
    @reservation = reservations(:one)
  end

  test "reservation should be valid" do
    assert @reservation.valid?
  end

  test "should belong to guest" do
    assert_respond_to(@reservation, :guest)
    assert_kind_of Guest, @reservation.guest
  end

  test "code should be present" do
    @reservation.code = ""
    assert_not @reservation.valid?
  end

  test "code should be unique" do
    duplicate_reservation = @reservation.dup
    @reservation.save
    assert_not duplicate_reservation.valid?
  end

  test "start_date should be present" do
    @reservation.start_date = nil
    assert_not @reservation.valid?
  end

  test "end_date should be present" do
    @reservation.end_date = nil
    assert_not @reservation.valid?
  end

  test "end_date should be after start_date" do
    @reservation.start_date = Date.today
    @reservation.end_date = Date.yesterday
    assert_not @reservation.valid?
  end

  test "night_count should be present" do
    @reservation.night_count = nil
    assert_not @reservation.valid?
  end

  test "night_count should be greater than or equal to 0" do
    @reservation.night_count = -1
    assert_not @reservation.valid?
    @reservation.night_count = 0
    assert @reservation.valid?
  end

  test "guest_count should be present" do
    @reservation.guest_count = nil
    assert_not @reservation.valid?
  end

  test "guest_count should be greater than or equal to 0" do
    @reservation.guest_count = -1
    assert_not @reservation.valid?
    @reservation.guest_count = 0
    assert @reservation.valid?
  end

  test "adult_count should be present" do
    @reservation.adult_count = nil
    assert_not @reservation.valid?
  end

  test "adult_count should be greater than or equal to 0" do
    @reservation.adult_count = -1
    assert_not @reservation.valid?
    @reservation.adult_count = 0
    assert @reservation.valid?
  end

  test "children_count should be greater than or equal to 0" do
    @reservation.children_count = -1
    assert_not @reservation.valid?
    @reservation.children_count = 0
    assert @reservation.valid?
  end

  test "infant_count should be greater than or equal to 0" do
    @reservation.infant_count = -1
    assert_not @reservation.valid?
    @reservation.infant_count = 0
    assert @reservation.valid?
  end

  test "sub_total_price should be present" do
    @reservation.sub_total_price = nil
    assert_not @reservation.valid?
  end

  test "sub_total_price should be greater than or equal to 0" do
    @reservation.sub_total_price = -1
    assert_not @reservation.valid?
    @reservation.sub_total_price = 0
    assert @reservation.valid?
  end

  test "total_price should be present" do
    @reservation.total_price = nil
    assert_not @reservation.valid?
  end

  test "total_price should be greater than or equal to 0" do
    @reservation.total_price = -1
    assert_not @reservation.valid?
    @reservation.total_price = 0
    assert @reservation.valid?
  end

  test "status should be present" do
    @reservation.status = ""
    assert_not @reservation.valid?
  end
end

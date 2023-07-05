# frozen_string_literal: true

# == Schema Information
#
# Table name: reservations
#
#  id               :integer          not null, primary key
#  code             :string(100)      not null, indexed, unique
#  guest_id         :integer          not null, indexed, foreign key
#  start_date       :date             not null, indexed
#  end_date         :date             not null, indexed
#  night_count      :integer          not null
#  guest_count      :integer          not null
#  adult_count      :integer          not null
#  children_count   :integer
#  infant_count     :integer
#  currency         :string(100)      not null
#  sub_total_price  :decimal(10, 2)   not null
#  additional_price :decimal(10, 2)
#  total_price      :decimal(10, 2)   not null
#  status           :string(100)      not null
#  created_at       :datetime
#  updated_at       :datetime
#
class Reservation < ApplicationRecord
  belongs_to :guest

  validates :code, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :start_date, :end_date, :night_count, :guest_count, :adult_count, :currency, :sub_total_price, :total_price, :status, presence: true
  validates :night_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :guest_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :adult_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :children_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :infant_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :currency, :status, length: { maximum: 100 }
  validates :sub_total_price, :total_price, numericality: { greater_than_or_equal_to: 0 }
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, "must be after the start date") if end_date < start_date
  end
end

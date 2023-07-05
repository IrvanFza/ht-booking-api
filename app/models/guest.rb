# frozen_string_literal: true

# Schema Information
#
# Table name: guests
#
# id              :integer          not null, primary key
# first_name       :string(100)      not null, indexed
# last_name       :string(100)      indexed
# email           :string(100)      not null, indexed, unique
# phone_number    :string(25)
# created_at      :datetime         not null
# updated_at      :datetime         not null
#
class Guest < ApplicationRecord
  has_many :reservations

  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :phone_number, length: { maximum: 25 }

  before_save :downcase_email

  private

  # Converts email to all lower-case before save to database
  # To ensure the uniqueness of the email
  def downcase_email
    self.email = email.downcase
  end
end

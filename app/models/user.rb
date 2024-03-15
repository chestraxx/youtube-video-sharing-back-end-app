class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email

  scope :online, -> { where("last_seen_at > ?", 15.minutes.ago) }
end

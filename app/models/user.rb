class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true

  scope :online, -> { where("last_seen_at > ?", 15.minutes.ago) }
end

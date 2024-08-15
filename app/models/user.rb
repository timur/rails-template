class User < ApplicationRecord
  has_secure_password

  has_many :visits, class_name: "Ahoy::Visit"
  has_many :sessions, dependent: :destroy

  has_one_attached :avatar

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end

  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  normalizes :email, with: -> { _1.strip.downcase }

  validates :email, presence: true, uniqueness: true

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end
end

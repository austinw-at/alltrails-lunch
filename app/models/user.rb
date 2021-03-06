class User < ApplicationRecord
  encrypts :token, deterministic: true

  has_many :favorites

  before_create :set_token

  validates :token, uniqueness: true, allow_blank: true
  validates :name, presence: true

  def set_token
    self.token = SecureRandom.hex if token.nil?
  end
end

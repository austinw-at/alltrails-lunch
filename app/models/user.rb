class User < ApplicationRecord
  encrypts :token, deterministic: true

  before_create :set_token

  validates :token, uniqueness: true, allow_blank: true
  validates :name, presence: true

  def set_token
    self.token = SecureRandom.hex if self.token.nil?
  end
end
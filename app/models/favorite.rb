class Favorite < ApplicationRecord
  belongs_to :user

  validates :place_id, presence: true, uniqueness: { scope: :user }
end

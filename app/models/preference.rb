class Preference < ApplicationRecord
  validates :key, :value, presence: true
end

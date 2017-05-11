class Podcast < ApplicationRecord
	belongs_to :station, optional: true
	validates :name, :stream_url, presence: true
end

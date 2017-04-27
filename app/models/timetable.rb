class Timetable < ApplicationRecord
	validates :name, :image, :streaming_hour, :end_streaming_hour, :broadcasters, presence: true
	belongs_to :station, optional: true
end

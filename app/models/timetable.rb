class Timetable < ApplicationRecord
	validates :name, :image, :streaming_hour, :end_streaming_hour, :broadcasters, presence: true
	belongs_to :station, optional: true
	validate :review_amazon_on_timetable_images

	private 
		def review_amazon_on_timetable_images	
			if !self.image.include? "amazon" or !self.broadcaster_image.include? "amazon"
				errors.add(:base, "La imagen no se subió bien, vuelve a intentar.")
			end
		end
end

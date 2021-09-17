class Hashtag < ApplicationRecord
	has_and_belongs_to_many :articles

	def self.find_or_create_by(name)
		slug = I18n.transliterate(name)
		slug.strip!
		slug = slug.length < 1 ?  "default" : slug
		slug = slug.scan(/([[:alnum:]]+)/).join('_')
		slug = slug.length < 1 ?  "default" : slug
		slug = slug.downcase
		result = self.find_by(name: name)
		if result == nil
			result = self.create(name: name)
			result.slug = slug == 'default' ? "#{result.id}" : slug
			result.save
		end
		puts result.slug
		result
	end
end

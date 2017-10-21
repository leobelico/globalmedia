class BannerSerializer < ActiveModel::Serializer 
	attributes :large_image, :small_image, :size, :created_at, :updated_at, :name, :global, :titlepage, :client, :url, :active, :expiry_date
	has_many :section_banners, each_serializer: SectionBannerSerializer
end	
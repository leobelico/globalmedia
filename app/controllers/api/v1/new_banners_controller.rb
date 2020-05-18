class Api::V1::NewBannersController < Api::BaseController
	def index

		exclude_columns = ['content']
		columns = NewBanner.attribute_names - exclude_columns
		@banners = NewBanner.select(columns).order('updated_at DESC')
		json_response(@banners, :ok)
	end
	def get_new_banners_now
		time = DateTime.now.to_date
		@banners = NewBanner.where("'#{time}' BETWEEN show_at AND expiry_at AND is_active = 'true'").order('updated_at DESC')
		json_response(@banners, :ok)
	end
	def find_by_id
		id = params['id']
		@banners = NewBanner.where("id = '#{id}'").first
		json_response(@banners, :ok)
	end
	def get_new_banner_show_now
		banner_type = params['type']
		time = DateTime.now.to_date
		@banners = NewBanner.where("'#{time}' BETWEEN show_at AND expiry_at AND is_active = 'true' and banner_type = '#{banner_type}'").order('updated_at DESC').first
		json_response(@banners, :ok)
	end
	def create
		banner = NewBanner.new
		banner.name = params['name']
		banner.description = params['description']
		banner.banner_type = params['banner_type']
		banner.content = params['content']
		banner.is_active = params['is_active']
		banner.show_at = params['show_at']
		banner.expiry_at = params['expiry_at']
		banner.save
		json_response(banner, :ok)
	end
	def update
		id = params['id']
		banner = NewBanner.where(:id => id).first
		if banner
			banner.name = params['name']
			banner.description = params['description']
			banner.banner_type = params['banner_type']
			banner.content = params['content']
			banner.is_active = params['is_active']
			banner.show_at = params['show_at']
			banner.expiry_at = params['expiry_at']
			banner.updated_at = DateTime.now
			banner.save
		end
		json_response(banner, :ok)
	end
	def delete
		id = params['id']
		banner = NewBanner.where(:id => id).first
		if banner
			banner.delete
		end
		json_response(banner, :ok)
	end
end

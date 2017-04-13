class AddBannerIdToSectionBanners < ActiveRecord::Migration[5.0]
  def change
    add_reference :section_banners, :banner, foreign_key: true
  end
end

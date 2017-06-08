class AddExpiryDateToBanners < ActiveRecord::Migration[5.0]
  def change
    add_column :banners, :expiry_date, :datetime
  end
end

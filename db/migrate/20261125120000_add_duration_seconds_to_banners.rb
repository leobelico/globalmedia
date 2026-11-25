# Segundos que cada banner se queda en pantalla antes de pasar al siguiente del carrusel.
class AddDurationSecondsToBanners < ActiveRecord::Migration[6.1]
  def up
    add_column :banners, :duration_seconds, :integer, default: 8 unless column_exists?(:banners, :duration_seconds)
  end

  def down
    remove_column :banners, :duration_seconds if column_exists?(:banners, :duration_seconds)
  end
end

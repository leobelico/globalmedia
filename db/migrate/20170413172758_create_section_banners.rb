class CreateSectionBanners < ActiveRecord::Migration[5.0]
  def change
    create_table :section_banners do |t|
    	t.integer :sectionable_id
      	t.string  :sectionable_type
      t.timestamps
    end
    add_index :section_banners, [:sectionable_type, :sectionable_id]
  end
end

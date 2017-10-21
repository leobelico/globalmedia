class CreateRelatedSections < ActiveRecord::Migration[5.0]
  def change
    create_table :related_sections do |t|

      t.timestamps
    end
  end
end

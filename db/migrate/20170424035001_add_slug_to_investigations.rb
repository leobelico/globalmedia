class AddSlugToInvestigations < ActiveRecord::Migration[5.0]
  def change
    add_column :investigations, :slug, :string, default: ""
  end
end

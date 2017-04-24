class AddSlugToInvestigations < ActiveRecord::Migration[5.0]
  def change
    add_column :relationships, :slug, :string, default: ""
    add_column :relationships, :relationship_type, :string, default: ""
  end
end

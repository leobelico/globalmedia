class AddInvestigationIdToArticles < ActiveRecord::Migration[5.0]
  def change
    add_reference :articles, :investigation, foreign_key: true
  end
end

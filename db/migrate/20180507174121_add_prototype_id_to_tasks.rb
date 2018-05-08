class AddPrototypeIdToTasks < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :prototype, foreign_key: true
  end
end

class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :finished, default: false
      t.integer :priority, default: 1

      t.timestamps
    end
  end
end

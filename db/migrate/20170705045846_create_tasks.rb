class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :finished
      t.integer :priority

      t.timestamps
    end
  end
end

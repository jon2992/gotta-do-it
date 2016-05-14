class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|

      t.boolean :completed, null: false
      t.string :name, null: false
      t.text :description

      t.timestamps null: false
    end
  end
end

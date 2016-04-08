class CreatePeeps < ActiveRecord::Migration
  def change
    create_table :peeps do |t|
      t.string :name

      t.timestamps null: false
    end
    add_index :peeps, :name, unique: true
  end
end

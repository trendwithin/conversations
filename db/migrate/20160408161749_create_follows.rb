class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

class CreateChirps < ActiveRecord::Migration
  def change
    create_table :chirps do |t|
      t.string :name, null: false
      t.text :text, null: false
      t.string :in_reply_to, null: true
      t.datetime :created_at, null: false

      t.timestamps null: false
    end
    add_index :chirps, :name, unique: true
  end
end

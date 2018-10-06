class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.text :title, null: false
      t.text :url, null: false

      t.timestamps
    end
    add_index :pages, :url, unique: true
  end
end

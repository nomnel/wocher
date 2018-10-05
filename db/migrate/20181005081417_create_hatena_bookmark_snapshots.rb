class CreateHatenaBookmarkSnapshots < ActiveRecord::Migration[5.2]
  def change
    create_table :hatena_bookmark_snapshots do |t|
      t.references :page, foreign_key: true, null: false
      t.integer :count, default: 0, null: false
      t.date :date, index: true, null: false

      t.timestamps
    end
  end
end

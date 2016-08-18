class CreateSublistItems < ActiveRecord::Migration
  def change
    create_table :sublist_items do |t|
      t.string :title
      t.text :description
      t.string :adress

      t.timestamps null: false
    end
  end
end

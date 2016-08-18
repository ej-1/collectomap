class CreateSublists < ActiveRecord::Migration
  def change
    create_table :sublists do |t|
      t.string :title
      t.text :description
      t.integer :list_id
      
      t.timestamps null: false
    end
  end
end

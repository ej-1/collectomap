class AddImageToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :image, :string
  end
end

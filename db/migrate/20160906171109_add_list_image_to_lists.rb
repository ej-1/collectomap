class AddListImageToLists < ActiveRecord::Migration
  def change
  	add_column :lists, :list_image, :string
  end
end

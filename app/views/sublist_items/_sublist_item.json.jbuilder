json.extract! sublist_item, :id, :title, :description, :adress, :created_at, :updated_at
json.url sublist_item_url(sublist_item, format: :json)
json.extract! sublist, :id, :title, :description, :adress, :created_at, :updated_at
json.url sublist_url(sublist, format: :json)
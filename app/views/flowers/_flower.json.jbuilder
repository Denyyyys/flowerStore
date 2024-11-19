json.extract! flower, :id, :name, :description, :price, :stock, :created_at, :updated_at
json.url flower_url(flower, format: :json)

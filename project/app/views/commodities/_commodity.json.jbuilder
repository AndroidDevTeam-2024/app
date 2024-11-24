json.extract! commodity, :id, :name, :price, :introduction, :business_id, :homepage, :exist, :created_at, :updated_at
json.url commodity_url(commodity, format: :json)

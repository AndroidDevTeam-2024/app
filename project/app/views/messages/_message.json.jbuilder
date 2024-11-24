json.extract! message, :id, :date, :content, :publisher, :acceptor, :created_at, :updated_at
json.url message_url(message, format: :json)

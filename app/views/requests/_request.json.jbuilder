json.extract! request, :id, :display_name, :reason, :dollar_amount, :created_at, :updated_at
json.url request_url(request, format: :json)

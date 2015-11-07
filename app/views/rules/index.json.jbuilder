json.array!(@rules) do |rule|
  json.extract! rule, :id, :rule_type, :name, :description, :summary, :capabilities, :code
  json.url rule_url(rule, format: :json)
end

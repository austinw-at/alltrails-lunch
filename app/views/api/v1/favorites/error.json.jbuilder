json.error do
  json.message @favorite.errors.full_messages.to_sentence
end
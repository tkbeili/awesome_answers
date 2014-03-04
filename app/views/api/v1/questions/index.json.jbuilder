json.questions @questions do |question|
  json.title question.title
  json.body question.body
  json.url question_url(question)
  json.created_at question.created_at.strftime("%Y-%B-%d")
end
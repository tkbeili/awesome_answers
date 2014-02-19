require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "a task is valid with a valid name" do
    q = Question.new
    q.title = "abc"
    q.body  = "asdfas fasdf "
    assert t.valid?
  end
end

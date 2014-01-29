class AnswerMailer < ActionMailer::Base
  default from: "do-not-reply@gmail.com"

  def new_answer(answer)
    @answer   = answer
    @question = answer.question
    @user     = @question.user
    mail(to: @user.email, subject: "You got new answer for your question #{@question.title}")
  end

end
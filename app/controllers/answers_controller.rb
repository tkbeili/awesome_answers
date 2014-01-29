class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

  def create
    @answer      = @question.answers.new(answer_attributes)
    @answer.user = current_user
    if @answer.save
      AnswerMailer.delay.new_answer(@answer)
      redirect_to @question, notice: "Thanks for your answer"
    else
      render "questions/show"
    end
  end

  def destroy
    @answer      = @question.answers.find(params[:id])
    @answer.user = current_user
    @answer.destroy
    redirect_to @question, notice: "Answer deleted successfully!"
  end

  private

  def answer_attributes
    params.require(:answer).permit([:body])
  end

  def find_question
    @question = current_user.questions.find(params[:question_id])
  end

end
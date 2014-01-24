class AnswersController < ApplicationController
  before_action :find_question

  def create
    @answer = @question.answers.new(answer_attributes)
    if @answer.save
      redirect_to @question, notice: "Thanks for your answer"
    else
      render "questions/show"
    end
  end

  def destroy
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to @question, notice: "Answer deleted successfully!"
  end

  private

  def answer_attributes
    params.require(:answer).permit([:body])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

end
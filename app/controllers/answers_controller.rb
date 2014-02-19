class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

  def create
    @answer      = @question.answers.new(answer_attributes)
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        AnswerMailer.delay.new_answer(@answer)
        format.js   { render }
        format.html { redirect_to @question, notice: "Thanks for your answer" }
      else
        format.js   { render "/answers/new" }
        format.html { render "questions/show" }
      end
    end
  end

  def destroy
    @answer      = current_user.answers.find(params[:id])
    @answer.destroy
    respond_to do |format|
      format.js   { render }
      format.html { redirect_to @question, notice: "Answer deleted successfully!"}
    end
  end

  private

  def answer_attributes
    params.require(:answer).permit([:body])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

end
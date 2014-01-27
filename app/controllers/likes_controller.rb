class LikesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_question

  def create
    if @question.like_by current_user
      redirect_to @question, notice: "Thanks for liking the question"
    else
      redirect_to @question, notice: "Sorry there was trouble liking your question."
    end
  end

  def destroy
    if @question.unlike_by current_user
      redirect_to @question, notice: "The question has been unliked successfully."
    else
      redirect_to @question, notice: "Sorry there was trouble liking your question."
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

end
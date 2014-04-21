class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer  = Answer.find(params[:answer_id])
    @comment = @answer.comments.new(params.require(:answer).permit(:body))
    if @comment.save
      redirect_to @answer.question
    else
      flash.now[:alert] = "couldn't create comment!"
      @question = @answer.question
      render "/questions/show"
    end
  end

end

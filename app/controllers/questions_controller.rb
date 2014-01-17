class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params.require(:question).permit([:title, :body]))
    @question.save
    redirect_to questions_path
  end

  def show
    @question = Question.find(params[:id])
  end

end
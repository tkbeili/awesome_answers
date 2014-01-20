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

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update_attributes(params.require(:question).permit([:title, :body]))
    redirect_to questions_path
  end

  def show
    @question = Question.find(params[:id])
    @question.hit_count += 1
    @question.save
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  def like
    @question = Question.find(params[:id])
    @question.like_count += 1
    @question.save
    session[:liked_question_ids] ||= []
    session[:liked_question_ids] << @question.id
    redirect_to @question
  end

end
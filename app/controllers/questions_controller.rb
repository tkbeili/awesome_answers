class QuestionsController < ApplicationController
  before_action :find_question, only: [:edit, :update, :show, :destroy, :like]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path, notice: "Question created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def show
    @answer  = Answer.new
    @answers = @question.answers
    @question.hit_count += 1
    @question.save
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  def like
    @question.like_count += 1
    @question.save
    session[:liked_question_ids] ||= []
    session[:liked_question_ids] << @question.id
    redirect_to @question
  end

  private

  def question_params
    params.require(:question).permit([:title, :body])
  end

  def find_question
    @question = Question.find(params[:id])
  end

end
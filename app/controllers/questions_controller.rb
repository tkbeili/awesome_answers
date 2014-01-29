class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:edit, :update, :destroy, :like]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
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
    @question = Question.find(params[:id])
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
    params.require(:question).permit([:title, :body, {category_ids: []}])
  end

  def find_question
    @question = current_user.questions.find(params[:id])
  end

end
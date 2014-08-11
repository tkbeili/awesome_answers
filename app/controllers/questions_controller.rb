class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:edit, :update, :destroy, :like]

  def index
    @questions = Question.page(params[:page]).per_page(10)
    @top_questions = Question.order("hit_count DESC").limit(3)
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
      expire_fragment("top_questions")
      redirect_to questions_path
    else
      render :edit
    end
  end

  def show
    @question = Question.friendly.find(params[:id])
    @answer   = Answer.new
    @answers  = @question.answers
    @question.hit_count += 1
    @question.save
  end

  private

  def question_params
    params.require(:question).permit([:title, :body, :image, {category_ids: []}])
  end

  def find_question
    @question = current_user.questions.friendly.find(params[:id])
  end

end
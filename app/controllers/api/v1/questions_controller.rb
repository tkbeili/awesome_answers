class Api::V1::QuestionsController < Api::BaseController

  before_action :restrict_access

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    # render json: @question.to_json
  end


end


# $.ajax({
#   url: "http://localhost:3000/api/v1/questions"
# }).success(function(data) {
#   var json = $.parseJSON(data);
#   console.log(json);
# });
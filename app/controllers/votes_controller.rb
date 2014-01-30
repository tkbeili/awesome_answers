class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question
  before_action :find_vote, only: [:update, :destroy]

  def create
    @vote      = @question.votes.new vote_params
    @vote.user = current_user
    if @vote.save
      redirect_to @question, notice: "Vote recorded successfully!"
    else
      redirect_to @question, notice: "Problem recording your vote"
    end
  end

  def update
    if @vote.update_attributes vote_params
      redirect_to @question, notice: "Vote updated successfully!"
    else
      redirect_to @question, notice: "Problem updating your vote"
    end
  end

  def destroy
    if @vote.destroy
      redirect_to @question, notice: "Vote removed successfully!"
    else
      redirect_to @question, notice: "Problem removing your vote"
    end
  end

  private

  def vote_params
    params.require(:vote).permit([:is_up])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_vote
    @vote = current_user.votes.find(params[:id])
  end

end
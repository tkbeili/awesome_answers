class LikesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_likeable

  def create
    if @likeable.like_by current_user
      redirect_to likeable_redirect_path, notice: "Thanks for liking the #{resource_name}"
    else
      redirect_to likeable_redirect_path, notice: "Sorry there was trouble liking your #{resource_name}."
    end
  end

  def destroy
    if @likeable.unlike_by current_user
      redirect_to likeable_redirect_path, notice: "The #{resource_name} has been unliked successfully."
    else
      redirect_to likeable_redirect_path, notice: "Sorry there was trouble liking your #{resource_name}."
    end
  end

  private

  def find_likeable
    klass     = [Question, Answer].detect { |c| params["#{c.name.underscore}_id"] }
    @likeable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def resource_name
    @likeable.class.name.downcase
  end

  def likeable_redirect_path
    case @likeable
    when Question then @likeable
    when Answer   then @likeable.question
    end
  end

end
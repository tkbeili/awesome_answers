class TipsController < ApplicationController
  before_action :authenticate_user!

  def new
  end 


  def create
    charge = Stripe::Charge.create( amount: params[:amount].to_i * 100,
                                    currency: "cad",
                                    card: params[:stripe_card_token],
                                    description: "Tip from #{current_user.email}" )
    if charge["paid"]
      redirect_to root_path, notice: "Thanks for your tip, you're awesome!"
    else
      flash.now[:notice] = "Sorry! we couldn't charge your card.."
      render :new
    end
  end


end
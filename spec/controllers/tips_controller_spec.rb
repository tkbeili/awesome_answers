require "spec_helper"

describe TipsController  do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "#new" do
    it "should render new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "tipping" do

    it "redirects to home page on successful Stripe charge" do
      Stripe::Charge.stub(:create).and_return({"paid" => true})
      post :create
      expect(response).to redirect_to(root_path)
    end

    it "renders new template on unsuccessful charge" do
      Stripe::Charge.stub(:create).and_return({"paid" => false})
      post :create
      expect(response).to render_template(:new)
    end

  end
  
end
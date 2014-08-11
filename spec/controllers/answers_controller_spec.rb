require "spec_helper"

describe AnswersController do
  let(:user)     { create(:user) }
  let(:question) { create(:question, user: user) }


  describe "#create" do
    before { sign_in user }

    before do
      Delayed::Worker.delay_jobs = false
    end

    it "sends an email to question owner" do
      ActionMailer::Base.deliveries.clear
      post :create, question_id: question.id, answer: {body: "asdfasdf"}
      expect(ActionMailer::Base.deliveries).to have(1).item
    end

  end


end
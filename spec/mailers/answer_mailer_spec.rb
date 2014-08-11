require "spec_helper"

describe AnswerMailer do
  let(:user)     { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer)   { create(:answer, question: question)}

  describe "#new_answer" do

    subject { AnswerMailer.new_answer(answer) }

    its(:to)         { should eq([user.email])               }
    its(:from)       { should eq(["do-not-reply@gmail.com"]) }
    its("body.to_s") { should match /#{answer.body}/i        }

    ##### BEFORE REFACTORING
    # before do
    #   @mail = AnswerMailer.new_answer(answer)
    # end

    # it "sends email to question owner" do
    #   expect(@mail.to).to eq([user.email])
    # end

    # it "sets the 'from' to be do-not-reply@gmail.com" do
    #   expect(@mail.to).to eq([user.email])
    # end

    # it "sets the 'from' to be do-not-reply@gmail.com" do
    #   expect(@mail.body.to_s).to match /#{answer.body}/i
    # end
  end

end
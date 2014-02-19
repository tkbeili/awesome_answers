require "spec_helper"

describe LikesController do
  let(:user)     { FactoryGirl.create(:user)                         }
  let(:question) { FactoryGirl.create(:question)                     }
  let(:answer)   { FactoryGirl.create(:answer, question: question)   }

  before do
    request.env['warden'].stub :authenticate! => user
    controller.stub :current_user => user
  end

  describe "Liking" do
    context "a Question" do
      subject { post :create, question_id: question.id }
      it "adds a like to a question" do
        expect { subject }.to change{ question.likes.count }.by(1)
      end

      it "redirects to question's path when it's a question" do
        subject
        expect(response).to redirect_to question_path(question)
      end
    end

    context "an Answer" do
      subject { post :create, answer_id: answer.id }
      it "redirects to question's path when it's an answer" do
        subject
        expect(response).to redirect_to question_path(question)
      end

      it "add a like to an answer " do
        expect { subject }.to change{ answer.likes.count }.by(1)
      end
    end
  end

  describe "UnLiking" do

    context "a Question" do
      subject { delete :destroy, question_id: question.id }

      context "with no likes" do
        it "removes no like from the question" do
          expect {subject }.to change{ question.likes.count }.by(0)
        end

        it "keeps the like count to 0" do
          expect {subject }.to change{ question.like_count }.by(0)
        end
      end
  
      context "with a like" do
        let(:question) { FactoryGirl.create(:question, like_count: 1)              }
        let!(:like)    { FactoryGirl.create(:like, likeable: question, user: user) }

        it "removes a like from a question" do
          expect { subject }.to change{ question.likes.count }.by(-1)
        end

        it "decrements the like count by 1" do
          expect { subject }.to change{ question.reload.like_count }.by(-1)
        end

      end
    end

    context "an Answer" do
      subject { delete :destroy, answer_id: answer.id }

      context "with no likes" do
        it "removes no like from the answer" do
          expect {subject }.to change{ answer.likes.count }.by(0)
        end
      end
  
      context "with a like" do
        let(:question) { FactoryGirl.create(:question, like_count: 1)              }
        let!(:like)    { FactoryGirl.create(:like, likeable: answer, user: user) }

        it "removes a like from a n answer" do
          expect { subject }.to change{ answer.likes.count }.by(-1)
        end

      end
    end
  end
end
require "spec_helper"

describe CommentsController do
  
  let(:answer) { create(:answer) }
  let(:user)   { create(:user)   }

  def valid_request
    post :create, answer_id: answer.id, answer: {body: "some valid body"}
  end

  context "with user signed in" do

    before do
      sign_in user
    end

    describe "#create" do
           
      it "creates a comment for the answer with valid body" do
        expect do
          valid_request
        end.to change {Comment.count}.by(1)
      end

      it "associates the comment with the passed answer" do
        expect do
          valid_request
        end.to change {answer.comments.count}.by(1)
      end

      it "redirect to question page with succesful creation" do
        valid_request
        expect(response).to redirect_to(answer.question)
      end

      def invalid_request
        post :create, answer_id: answer.id, answer: {body: ""}
      end

      it "renders 'new' template" do
        invalid_request
        expect(response).to render_template("questions/show")
      end

      it "doesn't change the comment count in DB" do
        expect { invalid_request }.to_not change{ Comment.count }
      end

      it "displays flash message" do
        invalid_request
        expect(flash[:alert]).to be
      end


    end
  end

  context "without no signed in user" do
    it "should redirect" do
      expect { valid_request }.to_not change{Comment.count}
    end

  end

end
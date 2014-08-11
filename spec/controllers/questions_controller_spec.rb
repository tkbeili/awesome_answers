require "spec_helper"


describe QuestionsController do
  let(:user) { create(:user) }

  describe "#index" do
    let!(:question1) { create(:question) }
    let!(:question2) { create(:question) }
    let!(:question3) { create(:question) }

    it "Assigns a variable @questions" do
      get :index
      expect(assigns(:questions)).to be
    end

    it "Include all questions in the assigned @questions" do
      get :index
      expect(assigns(:questions)).to include [question1, question2]
    end

    context "with more than 10 records" do
      before { 20.times { create(:question) } }
      it "only includes 10 questions if there are more than 10" do
        get :index
        expect(assigns(:questions).length).to eq(10)
      end

      # it "starts from second page if params[:page] is passed" do
      #   questions = double(:questions)
      #   questions.stub(:per_page).and_return(questions)
      #   Question.should_receive(:page).with("2").and_return { questions }
      #   get :index, {page: 2}
      #   expect(assigns(:questions)).to eq(questions)
      # end
    end

  end

  describe "#new" do

    context "with signed in user" do
      before { sign_in user }

      it "assigns new question" do
        get :new
        expect(assigns(:question)).to be_a_new(Question)
      end

      it "renders new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

  end

  describe "#create" do

    def successful_request
      post :create, question: {title: "abcde", body: "ddffd"}
    end

    context "with no signed in user" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "with signed in user" do
      before { sign_in user }

      it "creates a question in the database" do
        expect { successful_request }.to change{Question.count}.by(1)
      end

      it "redirect to question show page" do
        successful_request
        expect(response).to redirect_to(questions_path)
      end
    end

  end

  describe "#edit" do
    context "with signed in user" do
      before { sign_in user }

      let(:question)  { create(:question, user: user) }

      let(:user2)     { create(:user) }
      let(:question2) { create(:question, user: user2) }
      
      it "assigns @question to the question with the id" do
        get :edit, id: question.id
        expect(assigns(:question)).to eq(question)
      end

      it "doesn't 404 for non-owners" do
        expect{ get :edit, id: question2.id }.to raise_error
      end
    end

  end

  describe "#update" do
    let(:question) { create(:question, user: user) }

    context "with signed in user" do
      before { sign_in user}

      it "updates the question with new title if one is passed" do
        patch :update, id: question.id, question: {title: "some new title"}
        question.reload
        expect(question.title).to match /some new title/i
      end

      it "dones't update non passed parameters" do
        original_body = question.body
        patch :update, id: question.id, question: {title: "asdfasdf"}
        question.reload
        expect(question.body).to eq(original_body)
      end

      it "render edit with invalid update" do
        patch :update, id: question.id, question: {title: ""}
        expect(response).to render_template(:edit)
      end

    end

  end

  describe "#show" do
    let!(:question) { create(:question) }

    it "assigns a question to the question with passed id" do
      get :show, id: question.id
      expect(assigns(:question)).to eq(question)
    end

    it "increments hit count" do
      get :show, id: question.id
      question.reload
      expect(question.hit_count).to eq(1)
    end

  end

end
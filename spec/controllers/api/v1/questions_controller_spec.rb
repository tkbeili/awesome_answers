require "spec_helper"

describe Api::V1::QuestionsController do
  render_views
  let(:api_key)    { create(:api_key)  }

  before do
    # controller.stub(:restrict_access).and_return nil
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
  end

  describe "fetching all questions" do
    let!(:question1) { create(:question) }
    let!(:question2) { create(:question) }


    before do
      get :index, {format: :json}, @authentication_params
    end

    it { expect(response).to be_success }
    it { expect(response.body).to include(question1.title) }
    it { expect(response.body).to include(question1.body)  }
    it { expect(response.body).to include(question2.title) }
    it { expect(response.body).to include(question2.body)  }

  end
  
  describe "fetching single question" do
    let(:question) { create(:question) }

    before do
      get :show, id: question.id, format: :json
    end

    it "includes question title" do
      body_json = JSON.parse(response.body)
      expect(body_json["title"]).to eq(question.title)
    end

  end

end
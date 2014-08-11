require "spec_helper"


feature "Creating Questions" do
  let(:user) { create(:user) }
  let!(:question ) { create(:question) }

  before do
    login_as(user, :scope => :user)
  end

  it "creates answer for the question", js: true do
    question = create(:question)
    visit question_path(question)
    fill_in "Enter New Answer", with: "Some valid new answer"
    click_on "Create Answer"
    expect(page).to have_text /Some valid new answer/i
    save_and_open_page
  end


end
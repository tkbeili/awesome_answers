require "spec_helper"


feature "Creating Questions" do
  let(:user) { create(:user) }

  before do
    login_as(user, :scope => :user)
  end

  it "Adds a question to the database" do
    visit root_path
    click_on "New Question"
    fill_in "Title", with: "Some valid question title"
    fill_in "Body", with: "Some valid question descrtipion"
    click_on "Create Question"
    expect(current_path).to eq(questions_path)
    expect(page).to have_text /Some valid question title/i
  end

  it "Doesn't add a question with empty title" do
    visit root_path
    click_on "New Question"
    fill_in "Body", with: "Some valid question descrtipion"
    click_on "Create Question"
    save_and_open_page
    expect(page).to have_text /can\'t be blank/i
    expect(Question.count).to eq(0)
  end







end
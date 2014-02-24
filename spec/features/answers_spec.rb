require "spec_helper"


feature "Answering Questions"  do
  include Warden::Test::Helpers
  Warden.test_mode!

  let(:question) { create(:question) }

  scenario "A non-signed in user" do
    visit question_path(question)
    expect(page).to have_content 'Sign In To Answer'
  end

  # context "Signed In User" do
  #   before(:all) do
  #     user = create(:user)
  #     login_as(user, scope: :user)
  #   end

  #   scenario "Submitting an answer", js: true do
  #     visit question_url(question)
  #     fill_in "Enter New Answer", with: "my answer body goes here"
  #     expect(page).to have_content "my answer body goes here"
  #   end

  # end

end
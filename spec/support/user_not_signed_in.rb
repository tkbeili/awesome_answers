shared_examples "User Signed Out" do |action|

  it "redirects to new session path" do
    action.call
    expect(response).to redirect_to(new_user_session_path)
  end

end
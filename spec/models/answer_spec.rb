require 'spec_helper'

describe Answer do

  it "should capitalize answer" do
    answer = Answer.new(body: "valid uncapitalized body")
    answer.save
    expect(answer.reload.body).to eq("Valid uncapitalized body")
  end

end
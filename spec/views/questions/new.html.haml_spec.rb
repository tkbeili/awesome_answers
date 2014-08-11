require "spec_helper"

describe "questions/new.html.erb" do


  before do
    assign(:question, stub_model(Question))
    render
  end

  it "contains text 'Create New Question'" do
    expect(rendered).to match /Create New Question/i
  end

  it "renders 'form' template" do
    expect(rendered).to render_template(partial: "_form")
  end

  it "has .title selector" do
    expect(rendered).to have_selector(".title")
  end


end
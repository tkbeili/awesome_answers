require 'spec_helper'

describe Comment do

  it "doesn't allow creating a comment without a body" do
    comment = Comment.new
    comment.save
    # expect(comment.errors.message).to 
    comment.errors.message.should have_key(:body)
  end

  it "shouldn't allow creating a comment with a body less than four chars" do
    comment = Comment.new(body: "abc")
    comment.should_not be_valid
  end

  describe ".sanitaize" do
    it "removes double white spaces" do
      comment = Comment.new(body: "Text   with double spaces")
      comment.sanitaize
      expect(comment.body).to eq("Text with double spaces")
    end

    it "shouldn't remove double letter" do
      text_with_double_letter = "douuble lettters"
      comment = Comment.new(body: text_with_double_letter)
      comment.sanitaize
      expect(comment.body).to eq(text_with_double_letter)
    end

  end

  describe "Recent Ten" do

    before do
      11.times do |x|
        Comment.create(body: "some valid body #{x}")
      end
    end

    subject { Comment.recent_ten }

    its(:count) { should == 10 }
    # it "returns the ten records" do
    #   expect(Comment.recent_ten.count).to eq(10)
    # end

    it { should_not include(Comment.first) }

    # it "returns most recent" do
    #   expect(Comment.recent_ten).to_not include(Comment.first)
    # end
  end

end

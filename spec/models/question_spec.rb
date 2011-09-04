require 'spec_helper'

describe Question do

  it { should validate_presence_of :title }

  it { should validate_presence_of :body }

  it { should validate_presence_of :user }

  # Shoulda matchers for associations not working properly with mongomapper
  # as of the time of this test been written

  it "should have many answers" do
  	question = Fabricate(:question)

  	question.answers << Fabricate(:answer)
  	question.answers.length.should == 1
  	question.answers << Fabricate(:answer)
  	question.answers.length.should == 2
  end

  it "should belong to a user" do
    question = Fabricate(:question)
    question.user.should_not be_nil
  end

  it "should have a creator" do
    question = Fabricate(:question)
    question.creator.should_not be_nil
  end

end

require 'spec_helper'

describe Question do

  it { should validate_presence_of :title }

  it { should validate_presence_of :body }

  # Shoulda matchers for associations not working properly with mongomapper
  # as of the time of this test been written

  it "should have many answers" do
  	question = Fabricate(:generic_question)

  	question.answers << Fabricate(:blue_answer)
  	question.answers.length.should == 1
  	question.answers << Fabricate(:red_answer)
  	question.answers.length.should == 2
  end

  it "should belong to a user" do
    question = Fabricate(:joes_question)
    question.user.should_not be_nil
  end

end

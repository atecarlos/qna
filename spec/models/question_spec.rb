require 'spec_helper'

describe Question do

  before(:each) do
    @question = Fabricate(:question)
  end

  it { should validate_presence_of :title }

  it { should validate_presence_of :body }

  it { should validate_presence_of :creator }

  # Shoulda matchers for associations not working properly with mongomapper
  # as of the time of this test been written

  it "should have many answers" do
    @question.answers.length.should == 0
  	@question.answers << Fabricate(:answer)
  	@question.answers.length.should == 1
  	@question.answers << Fabricate(:answer)
  	@question.answers.length.should == 2
  end

end

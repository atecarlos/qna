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
  	add_answer
  	@question.answers.length.should == 1
  	add_answer
  	@question.answers.length.should == 2
  end

  it "has a creator who is a user" do
      @question.creator.should be_kind_of User
  end

  it "should destroy all answers when question is destroyed" do
    add_answer
    add_answer
    @question.answers[0].save
    @question.answers[1].save
    @question.answers[0].should be_persisted
    @question.answers[1].should be_persisted

    id1, id2 = @question.answers.map { |a| a.id }
    @question.destroy
    Answer.find(id1).should be_nil
    Answer.find(id2).should be_nil 
  end

  private 
    def add_answer
      @question.answers.build(body:'hello world', creator:User.new)
    end

end

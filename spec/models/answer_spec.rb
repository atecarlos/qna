require 'spec_helper'

describe Answer do

	before(:each) do
		@answer = Fabricate(:answer)
	end

	it { should validate_presence_of :body }
  	it { should validate_presence_of :user }
  	it { should validate_presence_of :question }

  	it "should belong to a question" do
  		@answer.question.should_not be_nil
  	end

  	it "should belong to a user" do
    	@answer.user.should_not be_nil
  	end

  	it "should have a creator" do
  		@answer.creator.should_not be_nil
  	end

    it "should have an assignable creator" do
      creator = Fabricate(:user)
      @answer.creator = creator
      @answer.creator.should be creator 
    end

end

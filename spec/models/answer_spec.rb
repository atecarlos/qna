require 'spec_helper'

describe Answer do

	it { should validate_presence_of :body }
  	it { should validate_presence_of :user }

  	it "should belong to a user" do
    	question = Fabricate(:answer)
    	question.user.should_not be_nil
  	end

  	it "should have a creator" do
  		question = Fabricate(:answer)
  		question.creator.should_not be_nil
  	end

end

require 'spec_helper'

describe Answer do

	it { should validate_presence_of :body }
  	it { should validate_presence_of :user }

  	it "should belong to a user" do
    	question = Fabricate(:answer)
    	question.user.should_not be_nil
  	end

end

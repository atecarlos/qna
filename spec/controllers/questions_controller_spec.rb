require 'spec_helper'

describe QuestionsController do

	it "should load all questions" do
		question = Fabricate(:question)
		get "index"

		response.should be_success
		assigns(:questions).should_not be_nil
		assigns(:questions).length.should == 1
		assigns(:questions).should include question
	end

end

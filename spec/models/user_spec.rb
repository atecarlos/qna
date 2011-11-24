require 'spec_helper'

describe User do

  	it "should have many questions" do
  		user = User.new
  		user.questions.length.should == 0
  		user.questions << Fabricate(:question)
  		user.questions.length.should == 1 
  	end

  	it "should have many answers" do
  		user = User.new
  		user.answers.length.should == 0
  		user.answers << Fabricate(:answer)
  		user.answers.length.should == 1
  	end

  	it "can be an admin" do
  		user = User.new
  		user.admin?.should be_false
		user.admin = true
		user.admin?.should be_true
  	end
end

require 'spec_helper'

describe @user do
    
    before(:each) do
      @user = User.new
    end

  	it "should have many questions" do
  		@user.questions.length.should == 0
  		@user.questions << Fabricate(:question)
  		@user.questions.length.should == 1 
  	end

  	it "should have many answers" do
  		@user.answers.length.should == 0
  		@user.answers << Fabricate(:answer)
  		@user.answers.length.should == 1
  	end

    it "can be a moderator" do
      @user.role = :moderator
      @user.moderator?.should be_true
      @user.role = :admin
      @user.moderator?.should be_false
    end

    it "can be a temp user" do
      @user.role = :temp
      @user.temp?.should be_true
      @user.role = :moderator
      @user.temp?.should be_false
    end
end

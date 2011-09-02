require 'spec_helper'

describe User do
  it "should have many questions" do
  	user = Fabricate(:user)
  	user.questions.length.should == 0

  	user.questions << Fabricate(:question)
  	user.questions.length.should == 1 
  end
end

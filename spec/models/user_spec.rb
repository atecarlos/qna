require 'spec_helper'

describe User do
  it "should have many questions" do
  	user = Fabricate(:pepe_3)
  	user.questions.length.should == 3
  end
end

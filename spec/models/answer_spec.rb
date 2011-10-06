require 'spec_helper'

describe Answer do

	before(:each) do
		@answer = Fabricate(:answer)
	end

	it { should validate_presence_of :body }
  	it { should validate_presence_of :creator }
  	it { should validate_presence_of :question }

  	it "has a creator who is a user" do
      @answer.creator.should be_kind_of User
  	end

end

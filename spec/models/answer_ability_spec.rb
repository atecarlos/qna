require 'spec_helper'
require 'cancan/matchers'

describe Ability do

	before(:each) do
		@user = mock_model(User)
		@ability = Ability.new(@user)

		@answer = Answer.new(creator:@user)

		another_user = mock_model(User)
		@another_users_answer = Answer.new(creator:another_user)
	end

	it "can manage answers" do
		@ability.should be_able_to(:manage, Answer)
	end

	it "can edit its own answers" do
		@ability.should be_able_to(:edit, @answer)
	end

	it "can delete its own answers" do
		@ability.should be_able_to(:destroy, @answer)
	end

	it "can't edit another users answers" do
		@ability.should_not be_able_to(:edit, @another_users_answer)
	end

	it "can't delete another users answers" do
		@ability.should_not be_able_to(:destroy, @another_users_answer)
	end
		
end
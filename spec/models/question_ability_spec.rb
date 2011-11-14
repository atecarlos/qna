require 'spec_helper'
require 'cancan/matchers'

describe Ability do

	before(:each) do
		@user = mock_model(User)
		@ability = Ability.new(@user)

		@question = Question.new(creator:@user)

		another_user = mock_model(User)
		@another_users_question = Question.new(creator:another_user)
	end

	it "can manage questions" do
		@ability.should be_able_to(:manage, Question)
	end

	it "can edit its own questions" do
		@ability.should be_able_to(:edit, @question)
	end

	it "can delete its own questions" do
		@ability.should be_able_to(:destroy, @question)
	end

	it "can't edit another users questions" do
		@ability.should_not be_able_to(:edit, @another_users_question)
	end

	it "can't delete another users questions" do
		@ability.should_not be_able_to(:destroy, @another_users_question)
	end
		
end
require 'spec_helper'
require 'cancan/matchers'

describe Ability do

	describe "For non admins" do

		before(:each) do
			build_objects
		end

		it "can read questions" do
			@ability.should be_able_to(:read, Question)
		end

		it "can create questions" do
			@ability.should be_able_to(:create, Question)
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

	describe "For admins" do

		before(:each) do
			build_objects for_admin:true
		end

		it "can read questions" do
			@ability.should be_able_to(:read, Question)
		end

		it "can create questions" do
			@ability.should be_able_to(:create, Question)
		end

		it "can edit any question" do
			@ability.should be_able_to(:edit, @question)
			@ability.should be_able_to(:edit, @another_users_question)
		end

		it "can delete any question" do
			@ability.should be_able_to(:destroy, @question)
			@ability.should be_able_to(:destroy, @another_users_question)
		end

	end

	private

		def build_objects(for_admin = false)
			@user = mock_model(User, admin?:for_admin)
			@ability = Ability.new(@user)

			@question = Question.new(creator:@user)

			another_user = mock_model(User)
			@another_users_question = Question.new(creator:another_user)
		end	
end
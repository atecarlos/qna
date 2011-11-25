require 'spec_helper'
require 'cancan/matchers'

describe Ability do
	
		describe "For non admins" do

		before(:each) do
			build_objects
		end

		it "can read answers" do
			@ability.should be_able_to(:read, Answer)
		end

		it "can create answers" do
			@ability.should be_able_to(:create, Answer)
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

	describe "For admins" do

		before(:each) do
			build_objects for_admin:true
		end

		it "can read answers" do
			@ability.should be_able_to(:read, Answer)
		end

		it "can create answers" do
			@ability.should be_able_to(:create, Answer)
		end

		it "can edit any question" do
			@ability.should be_able_to(:edit, @answer)
			@ability.should be_able_to(:edit, @another_users_answer)
		end

		it "can delete any question" do
			@ability.should be_able_to(:destroy, @answer)
			@ability.should be_able_to(:destroy, @another_users_answer)
		end

	end

	private 
		def build_objects(for_admin = false)
			@user = mock_model(User, admin?:for_admin)
			@ability = Ability.new(@user)

			@answer = Answer.new(creator:@user)

			another_user = mock_model(User)
			@another_users_answer = Answer.new(creator:another_user)
		end
		
end
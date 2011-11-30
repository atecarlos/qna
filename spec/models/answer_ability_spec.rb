require 'spec_helper'
require 'cancan/matchers'

describe Ability do
	
	subject { Ability.new(@user) }
		
	context "For non admins" do

		before(:each) do
			build_objects
		end

		it "can read answers" do
			should be_able_to(:read, Answer)
		end

		it "can create answers" do
			should be_able_to(:create, Answer)
		end

		it "can edit its own answers" do
			should be_able_to(:edit, @answer)
		end

		it "can delete its own answers" do
			should be_able_to(:destroy, @answer)
		end

		it "can't edit another users answers" do
			should_not be_able_to(:edit, @another_users_answer)
		end

		it "can't delete another users answers" do
			should_not be_able_to(:destroy, @another_users_answer)
		end

	end

	context "For admins" do

		before(:each) do
			build_objects for_admin:true
		end

		it "can read answers" do
			should be_able_to(:read, Answer)
		end

		it "can create answers" do
			should be_able_to(:create, Answer)
		end

		it "can edit any question" do
			should be_able_to(:edit, @answer)
			should be_able_to(:edit, @another_users_answer)
		end

		it "can delete any question" do
			should be_able_to(:destroy, @answer)
			should be_able_to(:destroy, @another_users_answer)
		end

	end

	private 
		def build_objects(for_admin = false)
			@user = mock_model(User, admin?:for_admin)

			@answer = mock_model(Answer, creator:@user)

			another_user = mock_model(User)
			@another_users_answer = mock_model(Answer, creator:another_user)
		end
		
end
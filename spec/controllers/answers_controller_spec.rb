require 'spec_helper'

describe AnswersController do

	before(:each) do
		@user = mock('user')
		mock_sign_in_with @user
		
		@body = "my answer"
    	@question_id = 99
    	@answer_id = 88
    	@answer_params = { 'body' => @body }

		@question = mock('question')
		@question.stub!(:id).and_return(@question_id)

		@answer = mock('answer')
		@answer.stub!(:id).and_return(@answer_id)
		@answer.stub!(:creator).and_return(@user)
				
		#for decent exposure
		@question.stub!(:attributes=)
		@question.stub!(:persisted?).and_return(true)
		@answer.stub!(:attributes=)
        
	end

	it "should expose the question in context" do
		setup_question_mock
		
		do_index
		
		controller.question.should_not be_nil
		controller.question.should == @question
	end

	it "should expose all answers for the question" do
		setup_answers_mock

		do_index

		controller.answers.length.should == 1
		controller.answers[0].should be @answer
	end

	it "should have a new action" do
		do_new

		response.should be_successful
	end

	it "should show all answers after after successfully adding one" do
		setup_create_mock
		
		do_create
		response.should redirect_to question_answers_path(@question)
	end

	it "should remain on new answer page if validation errors" do
		setup_invalid_create_mock

		do_create_invalid
		response.should render_template('new')
	end

	it "should expose an answer for edit" do
		setup_edit_mock
		do_edit

		response.should be_successful
		controller.answer.should be @answer
	end

	it "should should show all answers after a successful update" do
		setup_update_mock

		do_update

		response.should redirect_to question_answers_path(@question)
	end

	it "should remain in edit form if unsuccessful edit" do
		setup_invalid_update_mock

		do_invalid_update

		response.should render_template "edit"
	end

	it "should not allow editing of another users answer" do
		another_user = mock('another_user')
		mock_sign_in_with another_user
		setup_edit_mock

		@answer.should_not_receive :update_attributes
		do_update

		response.should redirect_to question_answers_path(@question)
	end

	private

		def setup_question_mock
			Question.should_receive(:find)
					.with(@question_id.to_s)
					.and_return(@question)
		end

		def setup_answers_mock
			setup_question_mock
			@question.should_receive(:answers)
			     	 .and_return([ @answer ])
		end

		def setup_create_mock
			setup_answers_mock
			Answer.should_receive(:new).and_return(@answer)
			@answer.should_receive(:creator=).with(@user)
			@answer.should_receive(:question=).with(@question)
			@answer.should_receive(:save).and_return(true)
		end

		def setup_invalid_create_mock
			setup_answers_mock
			Answer.should_receive(:new).and_return(@answer)
			@answer.should_receive(:creator=).with(@user)
			@answer.should_receive(:question=).with(@question)
			@answer.should_receive(:save).and_return(false)
		end

		def setup_edit_mock
			setup_answers_mock
			Answer.should_receive(:find).with(@answer_id.to_s).and_return(@answer)
		end

		def setup_update_mock
			setup_edit_mock
			@answer.should_receive(:update_attributes)
			   	   .with(@answer_params)
			       .and_return(true)
		end

		def setup_invalid_update_mock
			setup_edit_mock
			@answer.should_receive(:update_attributes)
			   	   .with(@answer_params)
			       .and_return(false)
		end

		def do_index
			get "index", { question_id: @question.id }
		end

		def do_new
			get "new", { question_id: @question.id }
		end

		def do_create
			post "create", { answer:@answer_params, question_id: @question.id }
		end

		def do_create_invalid
			post "create", { answer:@answer_params, question_id: @question.id }
		end

		def do_edit
			get "edit", { question_id: @question.id, id:@answer.id }
		end

		def do_update
			post "update", { question_id: @question.id, id:@answer.id, answer:@answer_params }
		end

		def do_invalid_update
			post "update", { question_id: @question.id, id:@answer.id, answer:@answer_params }
		end
end

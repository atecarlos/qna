require 'spec_helper'

describe QuestionsController do

	before(:each) do
		@title = "new question"
		@body = "new question @body"
		@question_id = 99
		@question_params = { title:@title, body:@body}
		@question_params_post = { 'title' => @title, 'body' => @body}

		@question = mock_decent_exposure_model('Question', id:@question_id)
		
		@user = mock('user')
		mock_sign_in_with @user

		session[:return_to] = 'some_url'
	end

	it "should expose all questions" do
		Question.should_receive(:all)
				.and_return([ @question ])
		controller.questions.should_not be_nil
		controller.questions.length.should == 1
		controller.questions.should include @question
	end

	it "should have an index action" do
		get "index"
		response.should be_success
	end

	it "should expose the users questions" do
		@user.should_receive(:questions)
			 .and_return([ @question ])
		controller.users_questions.should_not be_nil
		controller.users_questions.length.should == 1
	end

	it "should show all of the users questions" do
		get "my_questions"
		response.should be_success
	end

	it "should have a new action" do
		get "new"
		response.should be_success
	end

	it "should expose a new question for creation" do
		controller.question.should_not be_nil
		controller.question.persisted?.should be_false
	end

	it "should set referrer in session when requesting form for new" do
		set_referrer_to my_questions_path
		get "new"
		
		session[:return_to].should == my_questions_path
	end

	it "should always redirect to return url in session when creating a new question" do
		setup_create_mock_expectations
		session[:return_to] = my_questions_path
		do_create
		
		response.should redirect_to my_questions_path
	end

	it "should not redirect when creating if invalid attributes provided" do
		setup_invalid_create_mock_expectations
		do_create_invalid

		response.should render_template('new')
	end
	
	it "should expose question for edit" do
		setup_edit_mock_expectations
		do_edit
		controller.question.should be @question
		response.should be_success
	end

	it "should store return url in session when requesting an edit form" do
		set_referrer_to my_questions_path
		do_edit

		session[:return_to].should == my_questions_path
	end

	it "should always redirect to return url in session after successfully updating a question" do
		setup_update_mock_expectations
		session[:return_to] = questions_path
		do_update
		response.should redirect_to questions_path
	end

	it "should remain in the edit form if there are validation errors when updating" do
		setup_invalid_update_mock_expectations
		do_update_invalid
		response.should render_template "edit"
	end

	it "should not allow editing of another users question" do
		session[:return_to] = questions_path
		another_user = mock('another_user')
		mock_sign_in_with another_user
		setup_edit_mock_expectations

		@question.should_not_receive :update_attributes
		do_update

		response.should redirect_to questions_path
	end

	it "should destroy a question and redirect back to referrer" do
		set_referrer_to questions_path
		setup_destroy_mock_expectations

		do_destroy
		response.should redirect_to questions_path
	end

	it "should not destroy another users question" do
		set_referrer_to my_questions_path
		another_user = mock('another_user')
		mock_sign_in_with another_user
		setup_edit_mock_expectations

		@question.should_not_receive :destroy
		do_destroy

		response.should redirect_to my_questions_path
	end

	private 
		def setup_create_mock_expectations
			Question.should_receive(:new)
					.with(@question_params_post)
					.and_return(@question)

			@question.should_receive(:creator=)
				 	 .with(@user)

			@question.should_receive(:save).and_return(true)
		end

		def setup_invalid_create_mock_expectations
			Question.should_receive(:new)
					.with(@question_params_post)
					.and_return(@question)

			@question.should_receive(:creator=)
				 	 .with(@user)

			@question.should_receive(:save).and_return(false)
		end

		def setup_edit_mock_expectations
			Question.should_receive(:find)
				 	.with(@question_id.to_s)
				 	.and_return(@question)

			@question.stub!(:creator).and_return(@user)
		end

		def setup_update_mock_expectations
			setup_edit_mock_expectations
			@question.should_receive(:update_attributes)
					 .with(@question_params_post)
					 .and_return(true)
		end

		def setup_invalid_update_mock_expectations
			setup_edit_mock_expectations
			@question.should_receive(:update_attributes)
				     .with(@question_params_post)
					 .and_return(false)
		end

		def setup_destroy_mock_expectations
			setup_edit_mock_expectations
			@question.should_receive(:destroy)
		end

		def do_create
			post "create", { question: @question_params }
		end

		def do_create_invalid
			post "create", { question: @question_params }
		end

		def do_edit
			get "edit", { id:@question.id }
		end

		def do_update
			put "update", { id:@question.id, question: @question_params }
		end	

		def do_update_invalid
			put "update", { id:@question.id, question: @question_params }
		end

		def do_destroy
			delete "destroy", { id: @question.id }
		end

		def set_referrer_to(url)
			request.env["HTTP_REFERER"] = url
		end
end

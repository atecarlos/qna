require 'spec_helper'

describe AnswersController do

	BODY = "my answer"
    QUESTION_ID = 99
    ANSWER_ID = 88

	before(:each) do
		@question = mock('question')
		@question.stub!(:id).and_return(QUESTION_ID)

		@answer = mock('answer')
		@answer.stub!(:id).and_return(ANSWER_ID)
				
		#for decent exposure
		@question.stub!(:attributes=)
		@question.stub!(:persisted?).and_return(true)
		@answer.stub!(:attributes=)

		@user = mock('user')

		request.env['warden'] = mock(Warden, :authenticate => @user,
                                             :authenticate! => @user)
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

	it "should create an answer" do
		setup_create_mock
		@answer.should_receive(:save)

		do_create
	end

	it "should show all answers after after successfully adding one" do
		setup_create_mock
		@answer.should_receive(:save).and_return(true)

		do_create
		response.should redirect_to question_answers_path(@question)
	end

	it "should remain on new answer page if validation errors" do
		setup_create_mock
		@answer.should_receive(:save).and_return(false)

		do_create_invalid

		response.should render_template('new')
	end

	it "should have an edit action" do
		do_edit

		response.should be_successful
	end

	it "should update an answer" do
		setup_update_mock
		
		@answer.should_receive(:update_attributes).with({ "body" => BODY })
		do_update
	end

	it "should should show all answers after a successful update" do
		setup_update_mock

		@answer.should_receive(:update_attributes)
			   .with({ "body" => BODY })
			   .and_return(true)
		do_update

		response.should redirect_to question_answers_path(@question)
	end

	it "should remain in edit form if unsuccessful edit" do
		setup_update_mock

		@answer.should_receive(:update_attributes)
			   .with({ "body" => "" })
			   .and_return(false)
		do_invalid_update

		response.should render_template "edit"
	end

	private
		def setup_question_mock
			Question.should_receive(:find)
					.with(QUESTION_ID.to_s)
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
		end

		def setup_update_mock
			setup_answers_mock
			Answer.should_receive(:find).with(ANSWER_ID.to_s).and_return(@answer)
		end

		def do_index
			get "index", { question_id: @question.id }
		end

		def do_new
			get "new", { question_id: @question.id }
		end

		def do_create
			post "create", { answer: { body: BODY }, question_id: @question.id }
		end

		def do_create_invalid
			post "create", { answer: {  }, question_id: @question.id }
		end

		def do_edit
			get "edit", { question_id: @question.id, id:@answer.id }
		end

		def do_update
			post "update", { question_id: @question.id, id:@answer.id, answer:{ body: BODY } }
		end

		def do_invalid_update
			post "update", { question_id: @question.id, id:@answer.id, answer:{ body: '' } }
		end
end

require 'spec_helper'

describe AnswersController do

	BODY = "my answer"

	before(:each) do
		@question = Fabricate(:answered_question)
		@answer = @question.answers[0]
		@user = Fabricate(:user)
		sign_in @user
	end

	it "should expose the question in context" do
		do_index
		
		controller.question.should_not be_nil
		controller.question.should == @question
	end

	it "should expose all answers for the question" do
		do_index

		controller.answers.length.should == 3
	end

	it "should have a new action" do
		do_new

		response.should be_successful
	end

	it "should create an answer" do
		do_create

		saved_answer = Answer.find_by_question_id_and_body(@question.id, BODY)
		saved_answer.body.should == BODY
		saved_answer.question.should == @question
	end

	it "should show all answers after after successfully adding one" do
		do_create
		response.should redirect_to question_answers_path(@question)
	end

	it "should remain on new answer page if validation errors" do
		do_create_invalid

		response.should render_template('new')
	end

	it "should have an edit action" do
		do_edit

		response.should be_successful
	end

	it "should update an answer" do
		do_update

		updated_answer = Answer.find(@answer.id)
		updated_answer.body.should == BODY
	end

	it "should should show all answers after a successful update" do
		do_update

		response.should redirect_to question_answers_path(@question)
	end

	it "should remain in edit form if unsuccessful edit" do
		do_invalid_update

		response.should render_template "edit"
	end

	private
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

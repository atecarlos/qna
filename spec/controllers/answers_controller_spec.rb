require 'spec_helper'

describe AnswersController do

	BODY = "my answer"

	before(:each) do
		@question = Fabricate(:answered_question)
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
end

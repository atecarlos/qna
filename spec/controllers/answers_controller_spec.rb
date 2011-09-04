require 'spec_helper'

describe AnswersController do

	BODY = "my answer"

	before(:each) do
		@question = Fabricate(:question)
		@user = Fabricate(:pepe)
		sign_in @user
	end

	it "should create an answer" do
		do_create

		saved_answer = Answer.find_by_question_id_and_body(@question.id, BODY)
		saved_answer.body.should == BODY
		saved_answer.question.should == @question
	end

	it "should show question if successful" do
		do_create
		response.should redirect_to question_path(@question)
	end

	it "should re-render the question with validation errors" do
		do_create_invalid

		response.should render_template('show')
	end

	private
		def do_create
			post "create", { answer: { body: BODY }, question_id: @question.id }
		end

		def do_create_invalid
			post "create", { answer: {  }, question_id: @question.id }
		end
end

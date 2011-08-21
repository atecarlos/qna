require 'spec_helper'

describe QuestionsController do

	before(:each) do
		@question = Fabricate(:question)
	end

	it "should expose all questions" do
		controller.questions.should_not be_nil
		controller.questions.length.should == 1
		controller.questions.should include @question
	end

	it "should have an index action" do
		get "index"

		response.should be_success
	end

	it "should create a new question" do
		post "create", { question: { title:"new question", body:"new question body"} }

		response.should redirect_to questions_path

		saved_question = Question.find_by_title("new question")
		saved_question.should_not be_nil
		saved_question.title.should == "new question"
		saved_question.body.should == "new question body"
	end

	it "should not redirect when creating if invalid attributes provided" do
		post "create", { question: { title:"", body:""} }
		response.should render_template('new')
	end

	it "should expose a question" do
		get "show", { id:@question.id }

		response.should be_success

		exposed_question = controller.question
		exposed_question.should_not be_nil
		exposed_question.title.should == @question.title
		exposed_question.body.should == @question.body
	end

	it "should expose question for edit" do
		get "edit", { id:@question.id }

		response.should be_success

		question_for_edit = controller.question
		question_for_edit.should_not be_nil
		question_for_edit.title.should == @question.title
		question_for_edit.body.should == @question.body
	end

	it "should update and show a question" do
		put "update", { id:@question.id, question: { title:"updated title", body:"updated body"} }

		response.should redirect_to question_path(@question)

		updated_question = controller.question
		updated_question.should_not be_nil
		updated_question.title.should == "updated title"
		updated_question.body.should == "updated body"
	end

	it "should remain in the edit form if there are validation errors when updating" do
		put "update", { id:@question.id, question: { title:"", body:""} }
		response.should render_template("edit")
	end

end

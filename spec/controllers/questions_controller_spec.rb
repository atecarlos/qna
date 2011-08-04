require 'spec_helper'

describe QuestionsController do

	before(:each) do
		@question = Fabricate(:question)
	end

	it "should load all questions" do
		get "index"

		response.should be_success
		assigns(:questions).should_not be_nil
		assigns(:questions).length.should == 1
		assigns(:questions).should include @question
	end

	it "should ready a new question" do
		get "index"

		response.should be_success
		assigns(:question).should_not be_nil
	end

	it "should save a new question" do
		post "create", { question: { title:"new question", body:"new question body"} }

		response.should redirect_to questions_path

		saved_question = Question.find_by_title("new question")
		saved_question.should_not be_nil
		saved_question.title.should == "new question"
		saved_question.body.should == "new question body"
	end

	it "should show a question" do
		get "show", { id:@question.id }

		response.should be_success

		shown_question = assigns(:question)
		shown_question.should_not be_nil
		shown_question.title.should == @question.title
		shown_question.body.should == @question.body
	end

	it "should show a question for edit" do
		get "edit", { id:@question.id }

		response.should be_success

		question_for_edit = assigns(:question)
		question_for_edit.should_not be_nil
		question_for_edit.title.should == @question.title
		question_for_edit.body.should == @question.body
	end

	it "should edit a question" do
		put "update", { id:@question.id, question: { title:"updated title", body:"updated body"} }

		response.should redirect_to question_path(@question)

		updated_question = assigns(:question)
		updated_question.should_not be_nil
		updated_question.title.should == "updated title"
		updated_question.body.should == "updated body"
	end

end

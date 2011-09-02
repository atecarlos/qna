require 'spec_helper'

describe QuestionsController do

	before(:each) do
		@question = Fabricate(:question)
		@user = Fabricate(:pepe)
		sign_in @user

		session[:return_to] = 'some_url'
	end

	it "should expose all questions" do
		controller.questions.should_not be_nil
		controller.questions.length.should == 4
		controller.questions.should include @question
	end

	it "should have an index action" do
		get "index"
		response.should be_success
	end

	it "should expose the users questions" do
		controller.users_questions.should_not be_nil
		controller.users_questions.length.should == 3
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
		request.env["HTTP_REFERER"] = my_questions_path
		get "new"
		
		session[:return_to].should == my_questions_path
	end

	it "should create a new question" do
		post "create", { question: { title:"new question", body:"new question body"} }

		saved_question = Question.find_by_title("new question")
		saved_question.should_not be_nil
		saved_question.title.should == "new question"
		saved_question.body.should == "new question body"
		saved_question.user.should == @user
	end

	it "should always redirect to return url in session when creating a new question" do
		session[:return_to] = questions_path
		post "create", { question: { title:"new question", body:"new question body"} }
		
		response.should redirect_to questions_path

		session[:return_to] = my_questions_path
		post "create", { question: { title:"another new question", body:"new question body"} }
		
		response.should redirect_to my_questions_path
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

	it "should store return url in session when requesting an edit form" do
		request.env["HTTP_REFERER"] = my_questions_path
		get "edit", { id:@question.id }

		session[:return_to].should == my_questions_path
	end

	it "should update a question" do
		put "update", { id:@question.id, question: { title:"updated title", body:"updated body"} }

		updated_question = controller.question
		updated_question.should_not be_nil
		updated_question.title.should == "updated title"
		updated_question.body.should == "updated body"
	end

	it "should always redirect to return url in session after successfully updating a question" do
		session[:return_to] = questions_path
		put "update", { id:@question.id, question: { title:"updated title", body:"updated body"} }
		response.should redirect_to questions_path

		session[:return_to] = my_questions_path
		put "update", { id:@question.id, question: { title:"updated title", body:"updated body 2"} }
		
		response.should redirect_to my_questions_path
	end

	it "should remain in the edit form if there are validation errors when updating" do
		put "update", { id:@question.id, question: { title:"", body:""} }
		response.should render_template("edit")
	end

end

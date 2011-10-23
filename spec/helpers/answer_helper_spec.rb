require 'spec_helper'

describe AnswerHelper do

	before(:each) do
		@user = mock('User')
  		mock_sign_in_with @user
	end

  	it "should render an edit link if current users answer" do
  		question = mock_question
  		answer = mock_answer_with question
  		answer.should_receive(:creator).and_return(@user)

  		helper.edit_link_for(answer).should == "<a href=\"/questions/my_question/answers/my_answer/edit\">Edit</a>"
  	end

  	it "should not render an edit link if not current users answer" do
  		another_user = mock('another_user')
  		question = mock_question
  		answer = mock_answer_with question
		answer.should_receive(:creator).and_return(another_user)
		 	
 		helper.edit_link_for(answer).should be_nil
  	end

  	private
  		def mock_question
	  		question = mock('Question')
	  		question.stub!(:id).and_return(1234)
	  		question.stub!(:to_s).and_return('my_question')
	  		question.stub!(:persisted?).and_return(true)
	  		return question
  		end

	  	def mock_answer_with(question)
	  		answer = mock('Answer')	
	  		answer.stub!(:persisted?).and_return(true)
	  		answer.stub!(:to_s).and_return('my_answer')
	  		answer.stub!(:question).and_return(question)
	  		return answer
	  	end
end
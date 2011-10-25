require 'spec_helper'

describe QuestionHelper do

  it "should render an edit link if current users answer" do
  	user = mock('user')
    question = mock_question
  	question.should_receive(:creator).and_return(user)
    should_receive(:current_user).and_return(user)

  	edit_link_for(question).should == "<a href=\"/questions/#{question.id}/edit\">Edit</a>"
  end

  it "should not render an edit link if not current users question" do
  	user = mock('user')
    another_user = mock('another_user')
  	question = mock_question
		question.should_receive(:creator).and_return(another_user)
		should_receive(:current_user).and_return(user)
     	
 		edit_link_for(question).should be_nil
  end

  private
  	def mock_question
	  	mock_model('Question', id:1234)
  	end
end
require 'spec_helper'

describe QuestionsHelper do

  it "should render an edit link if current users answer" do
  	setup_current_users_question

  	edit_link_for(@question).should == "<a href=\"/questions/#{@question.id}/edit\">Edit</a>"
  end

  it "should not render an edit link if not current users question" do
  	setup_not_current_users_question
     	
 		edit_link_for(@question).should be_nil
  end

  it "should render a delete link if current users question" do
    setup_current_users_question

    delete_link_for(@question).should == "<a href=\"/questions/#{@question.id}\" data-method=\"delete\" rel=\"nofollow\">Delete</a>"
  end

  it "should not render an edit link if not current users question" do
    setup_not_current_users_question
    delete_link_for(@question).should be_nil
  end

  private

    def setup_current_users_question
      user = mock('user')
      @question = mock_question
      @question.should_receive(:creator).and_return(user)
      should_receive(:current_user).and_return(user)
    end

    def setup_not_current_users_question
      user = mock('user')
      another_user = mock('another_user')
      @question = mock_question
      @question.should_receive(:creator).and_return(another_user)
      should_receive(:current_user).and_return(user)
    end

  	def mock_question
	  	mock_model('Question', id:1234)
  	end
end
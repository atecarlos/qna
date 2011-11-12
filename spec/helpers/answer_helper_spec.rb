require 'spec_helper'

describe AnswerHelper do

  	it "should render an edit link if current users answer" do
  		setup_current_users_answer

  		edit_link_for(@answer).should == "<a href=\"/questions/#{@question.id}/answers/#{@answer.id}/edit\">Edit</a>"
  	end

  	it "should not render an edit link if not current users answer" do
  		setup_not_current_users_answer
      edit_link_for(@answer).should be_nil
  	end

    it "should render a delete link if current users answer" do
      setup_current_users_answer

      delete_link_for(@answer).should == "<a href=\"/questions/#{@question.id}/answers/#{@answer.id}\" data-method=\"delete\" rel=\"nofollow\">Delete</a>"
    end

    it "should not render an edit link if not current users answer" do
      setup_not_current_users_answer
      delete_link_for(@answer).should be_nil
    end

  	private
  		def setup_current_users_answer
        user = mock('user')
        @answer = mock_answer
        
        @answer.should_receive(:creator).and_return(user)
        should_receive(:current_user).and_return(user)
      end

      def setup_not_current_users_answer
        user = mock('user')
        another_user = mock('another_user')
        
        @answer = mock_answer

        @answer.should_receive(:creator).and_return(another_user)
        should_receive(:current_user).and_return(@user)   
      end

	  	def mock_answer
        @question = mock_model('Question', id:1234)
	  		mock_model('Answer', id:5432, question:@question)
	  	end
end
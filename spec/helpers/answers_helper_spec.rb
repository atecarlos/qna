require 'spec_helper'

describe AnswersHelper do
    
  	it "should render an edit link if current users answer" do
  		@answer = mock_answer
      should_receive(:can?).with(:edit, @answer).and_return(true)  

  		edit_link_for(@answer).should == "<a href=\"/questions/#{@question.id}/answers/#{@answer.id}/edit\">Edit</a>"
  	end

  	it "should not render an edit link if not current users answer" do
  		@answer = mock_answer
      should_receive(:can?).with(:edit, @answer).and_return(false)
        
      edit_link_for(@answer).should be_nil
  	end

    it "should render a delete link if current users answer" do
      @answer = mock_answer
      should_receive(:can?).with(:destroy, @answer).and_return(true)  

      delete_link_for(@answer).should == "<a href=\"/questions/#{@question.id}/answers/#{@answer.id}\" data-method=\"delete\" rel=\"nofollow\">Delete</a>"
    end

    it "should not render an edit link if not current users answer" do
      @answer = mock_answer
      should_receive(:can?).with(:destroy, @answer).and_return(false)  
      delete_link_for(@answer).should be_nil
    end

  	private

	  	def mock_answer
        @question = mock_model('Question', id:1234)
	  		mock_model('Answer', id:5432, question:@question)
	  	end
end
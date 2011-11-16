require 'spec_helper'

describe AnswersHelper do
    
    before(:each) do
      @question = mock_model('Question', id:1234)
      @answer = mock_model('Answer', id:5432, question:@question)
    end

  	it "should render an edit link if can edit answer" do
      should_receive(:can?).with(:edit, @answer).and_return(true)  

  		edit_link_for(@answer).should == "<a href=\"/questions/#{@question.id}/answers/#{@answer.id}/edit\">Edit</a>"
  	end

  	it "should not render an edit link if can't edit answer" do
      should_receive(:can?).with(:edit, @answer).and_return(false)
        
      edit_link_for(@answer).should be_nil
  	end

    it "should render a delete link if can delete answer" do
      should_receive(:can?).with(:destroy, @answer).and_return(true)  

      delete_link_for(@answer).should == "<a href=\"/questions/#{@question.id}/answers/#{@answer.id}\" data-method=\"delete\" rel=\"nofollow\">Delete</a>"
    end

    it "should not render an edit link if can't delete answer" do
      should_receive(:can?).with(:destroy, @answer).and_return(false)
        
      delete_link_for(@answer).should be_nil
    end
end
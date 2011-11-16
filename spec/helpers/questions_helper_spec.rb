require 'spec_helper'

describe QuestionsHelper do

  before(:each) do
    @question = mock_model('Question', id:1234)
  end

  it "should render an edit link if can edit answer" do
    should_receive(:can?).with(:edit, @question).and_return(true)

  	edit_link_for(@question).should == "<a href=\"/questions/#{@question.id}/edit\">Edit</a>"
  end

  it "should not render an edit link if can't edit question" do
    should_receive(:can?).with(:edit, @question).and_return(false)
     	
 		edit_link_for(@question).should be_nil
  end

  it "should render a delete link if can delete question" do
    should_receive(:can?).with(:destroy, @question).and_return(true)

    delete_link_for(@question).should == "<a href=\"/questions/#{@question.id}\" data-method=\"delete\" rel=\"nofollow\">Delete</a>"
  end

  it "should not render a delete link if can't delete question" do
    should_receive(:can?).with(:destroy, @question).and_return(false)

    delete_link_for(@question).should be_nil
  end

end
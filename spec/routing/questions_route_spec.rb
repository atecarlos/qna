require 'spec_helper'

describe "routing to questions" do
  
  it "root should route to questions index" do
    { get:"/" }.should route_to( controller:"questions", action:"index" )
  end

  it "should not have a show action" do
    { get:"/questions/1" }.should_not be_routable
  end

  it "should not have a destroy action" do
    { delete:"/questions/1" }.should_not be_routable
  end

  it "should have a my-questions route" do
      { get:"/questions/my-questions" }.should route_to(
        controller:"questions", action:"my_questions" )
  end

  it "should have an index action" do
    { get:"/questions" }.should route_to(
      controller:'questions', action:'index' )
  end

  it "should have a new action" do
    { get:"/questions/new" }.should route_to(
      controller:"questions", action:"new" )
  end

  it "should have a create action" do
    { post:"/questions" }.should route_to(
      controller:"questions", action:"create" )
  end

  it "should have an edit action" do
    { get:"/questions/1/edit" }.should route_to(
      controller:"questions", id:"1", action:"edit" )
  end

  it "should have an update action" do
    { put:"/questions/1" }.should route_to(
      controller:"questions", id:"1", action:"update" )
  end

end
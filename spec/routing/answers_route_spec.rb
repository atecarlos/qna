require 'spec_helper'

describe "routing to answers" do
  
  it "should not have a show action" do
    { get:"/questions/1/answers/1" }.should_not be_routable
  end

  it "should have an index action" do
    { get:"/questions/1/answers" }.should route_to(
      controller:'answers', action:'index', question_id:'1' )
  end

  it "should have a new action" do
    { get:"/questions/1/answers/new" }.should route_to(
      controller:"answers", question_id:"1", action:"new" )
  end

  it "should have a create action" do
    { post:"/questions/1/answers/" }.should route_to(
      controller:"answers", question_id:"1", action:"create" )
  end

  it "should have an edit action" do
    { get:"/questions/1/answers/2/edit" }.should route_to(
      controller:"answers", question_id:"1", id:"2", action:"edit" )
  end

  it "should have an update action" do
    { put:"/questions/1/answers/2" }.should route_to(
      controller:"answers", question_id:"1", id:"2", action:"update" )
  end

  it "should have a destroy action" do
    { delete:"/questions/1/answers/2" }.should route_to(
      controller:"answers", question_id:"1", id:"2", action:"destroy" )
  end

end
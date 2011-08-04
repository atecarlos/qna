class QuestionsController < ApplicationController

	def index
		@question = Question.new
		@questions = Question.all
	end

	def create
		question = Question.new(params[:question])
		question.save
		redirect_to questions_path
	end

	def show
		@question = Question.find(params[:id])
	end

	def edit
		@question = Question.find(params[:id])
	end

	def update
		@question = Question.find(params[:id])
		@question.update_attributes(params[:question])
		redirect_to question_path(@question)
	end

end

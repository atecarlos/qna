class QuestionsController < ApplicationController

	expose(:questions) { Question.all }
	expose(:question)

	def index
	end

	def create
		question.save
		redirect_to questions_path
	end

	def show
	end

	def edit
	end

	def update
		question.update_attributes(params[:question])
		redirect_to question_path(question)
	end

end

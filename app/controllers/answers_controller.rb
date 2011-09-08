class AnswersController < ApplicationController

	expose(:question)
	expose(:answers) { question.answers }
	expose(:answer)	

	def index
	end

	def new
	end

	def create
		answer.creator = current_user
		answer.question = question
		if answer.save
			redirect_to question_answers_path(answer.question)
		else
			render :new
		end
	end

end

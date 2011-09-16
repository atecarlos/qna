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
			redirect_to_index
		else
			render :new
		end
	end

	def edit
	end

	def update
		if answer.update_attributes(params[:answer])
			redirect_to_index
		else
			render :edit
		end
	end

	private
		
		def redirect_to_index
			redirect_to question_answers_path(question)
		end
end

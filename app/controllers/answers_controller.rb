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
		if current_user_not_creator? or update_successful?
			redirect_to_index
		else
			render :edit
		end
	end

	def destroy
		answer.destroy unless current_user_not_creator?
		redirect_to_index
	end

	private
		def redirect_to_index
			redirect_to question_answers_path(question)
		end

		def current_user_not_creator?
			current_user != answer.creator
		end

		def update_successful?
			answer.update_attributes(params[:answer])
		end
end

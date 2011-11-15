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
		if cannot? :edit, answer or update_successful?
			redirect_to_index
		else
			render :edit
		end
	end

	def destroy
		answer.destroy if can? :destroy, answer
		redirect_to_index
	end

	private
		def redirect_to_index
			redirect_to question_answers_path(question)
		end

		def update_successful?
			answer.update_attributes(params[:answer])
		end
end

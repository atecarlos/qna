class AnswersController < ApplicationController

	expose(:answer)
	expose(:question)

	def create
		answer.creator = current_user
		answer.question = question
		if answer.save
			redirect_to question_path(answer.question)
		else
			render 'questions/show'
		end
	end

end

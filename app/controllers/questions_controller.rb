class QuestionsController < ApplicationController

	expose(:questions) { Question.all }
	expose(:question)

	# shells for index, new, show, edit actions
	# are provided by default

	def create
		if question.save
			redirect_to questions_path
		else
			render :new
		end
	end

	def update
		if question.update_attributes(params[:question])
			redirect_to question_path(question)
		else
			render :edit
		end
	end

end

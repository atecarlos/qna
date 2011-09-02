class QuestionsController < ApplicationController

	expose(:questions) { Question.all }
	expose(:question)
	expose(:users_questions) { current_user.questions }

	# basic index, new, show, edit actions are provided by default

	def my_questions
	end

	def create
		question.user = current_user
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

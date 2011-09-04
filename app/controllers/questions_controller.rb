class QuestionsController < ApplicationController

	expose(:questions) { Question.all }
	expose(:question)
	expose(:users_questions) { current_user.questions }

	before_filter :store_return_url, only: [:new, :edit]
	# basic index, new, show, edit actions are provided by default

	def my_questions
	end

	def create
		question.creator = current_user
		if question.save
			redirect_to session[:return_to]
		else
			render :new
		end
	end

	def update
		if question.update_attributes(params[:question])
			redirect_to session[:return_to]
		else
			render :edit
		end
	end

	private
		def store_return_url
			session[:return_to] = request.referer		
		end
end
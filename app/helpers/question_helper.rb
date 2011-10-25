module QuestionHelper

	def edit_link_for(question)
		link_to 'Edit', edit_question_path(question) if question.creator == current_user
	end

end
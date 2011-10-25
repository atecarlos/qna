module AnswerHelper

	def edit_link_for(answer)
		link_to 'Edit', edit_question_answer_path(answer.question, answer) if answer.creator == current_user
	end

end
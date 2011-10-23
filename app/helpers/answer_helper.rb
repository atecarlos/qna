module AnswerHelper

	def edit_link_for(answer)
		if answer.creator == current_user
			link_to 'Edit', edit_question_answer_path(answer.question, answer) 
		end
	end

end
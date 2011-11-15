module AnswersHelper

	def edit_link_for(answer)
		link_to 'Edit', edit_question_answer_path(answer.question, answer) if can? :edit, answer
	end

	def delete_link_for(answer)
		link_to 'Delete', question_answer_path(answer.question, answer), :method => :delete if can? :destroy, answer
	end

end
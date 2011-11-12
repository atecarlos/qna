module AnswerHelper

	def edit_link_for(answer)
		link_to 'Edit', edit_question_answer_path(answer.question, answer) if current_users? answer
	end

	def delete_link_for(answer)
		link_to 'Delete', question_answer_path(answer.question, answer), :method => :delete if current_users? answer
	end

	private
		def current_users?(answer)
			answer.creator == current_user
		end

end
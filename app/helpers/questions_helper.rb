module QuestionsHelper

	def edit_link_for(question)
		link_to 'Edit', edit_question_path(question) if current_users? question
	end

	def delete_link_for(question)
		link_to 'Delete', question_path(question), :method => :delete if current_users? question
	end

	private
		def current_users?(question)
			question.creator == current_user
		end

end
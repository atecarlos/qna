module QuestionsHelper

	def edit_link_for(question)
		link_to 'Edit', edit_question_path(question) if can? :edit, question
	end

	def delete_link_for(question)
		link_to 'Delete', question_path(question), :method => :delete if can? :destroy, question
	end

end
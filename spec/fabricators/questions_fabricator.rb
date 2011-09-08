Fabricator(:question) do
	title { sequence(:title) { |i| "my question #{i}" } }
	body 'How do I do this??'
	user { Fabricate(:user) }
end

Fabricator(:answered_question, :from => :question) do
	title { sequence(:title) { |i| "answered question #{i}" } }
	body 'Somebody should know how to do this...right?'
	user { Fabricate(:user) }
	answers(count: 3) { |this_question, i| Fabricate(:answer, question: this_question, user: this_question.user) }
end
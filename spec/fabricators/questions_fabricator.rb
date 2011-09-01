Fabricator(:generic_question, :from => :question) do
	title 'This is my title'
	body 'How do I do this??'
end

Fabricator(:joes_question, :from => :question) do
	title 'My name!'
	body 'What is my name?'
	user { Fabricate(:joe) }
end
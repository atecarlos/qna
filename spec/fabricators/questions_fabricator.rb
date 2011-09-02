Fabricator(:question) do
	title { sequence(:title) { |i| "my question #{i}" } }
	body 'How do I do this??'
	user { Fabricate(:user) }
end
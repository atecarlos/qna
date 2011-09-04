Fabricator(:answer) do
	body { sequence(:body) { |i| "My #{i} answer" } }
	user { Fabricate(:user) }
	question { Fabricate(:question) }
end
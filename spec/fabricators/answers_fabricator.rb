Fabricator(:answer) do
	body { sequence(:body) { |i| "My #{i} answer" } }
	creator { Fabricate(:user) }
	question { Fabricate(:question) }
end
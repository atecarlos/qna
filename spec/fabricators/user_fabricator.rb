Fabricator(:user) do
	email { sequence(:email) { |i| "user#{i}@test.com" } }
	password 'asuper_password'
end

Fabricator(:pepe, :from => :user) do
	email { sequence(:email) { |i| "pepe_#{i}@email.com" } }
	password "claves"
	questions(count: 3) { |this_user, i| Fabricate(:question, user: this_user) }
end

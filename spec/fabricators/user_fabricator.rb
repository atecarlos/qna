Fabricator(:user) do
	email { sequence(:email) { |i| "user#{i}@test.com" } }
	password 'asuper_password'
end

Fabricator(:pepe_3, :from => :user) do
	email "pepe@email.com"
	password "claves"
	questions(:count => 3) { |this_user, i| Fabricate(:generic_question, :user => this_user) }
end

Fabricator(:joe, :from => :user) do
	email 'joe@email.com'
	password 'my_pass'
end

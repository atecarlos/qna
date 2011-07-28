class Question
	include MongoMapper::Document

	key :title, String
  	key :body, String
end

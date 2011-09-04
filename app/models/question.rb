class Question
	include MongoMapper::Document

	key :title, String, required:true
  	key :body, String, required:true

  	validates_presence_of :user

  	belongs_to :user
  	many :answers
end

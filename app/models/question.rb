class Question
	include MongoMapper::Document

	key :title, String, required:true
  	key :body, String, required:true

  	belongs_to :creator, :through => :user
  	validates_presence_of :creator

  	many :answers
end

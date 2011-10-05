class Answer
	include MongoMapper::Document

  	key :body, String, :required => true

  	belongs_to :creator, :through => :user
  	validates_presence_of :creator

  	belongs_to :question
  	validates_presence_of :question
end
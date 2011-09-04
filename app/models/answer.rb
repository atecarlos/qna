class Answer
	include MongoMapper::Document

  	key :body, String, :required => true

  	belongs_to :user
  	validates_presence_of :user
  	alias :creator :user
  	alias :creator= :user=

  	belongs_to :question
  	validates_presence_of :question
end
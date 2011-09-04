class Answer
	include MongoMapper::Document

  	key :body, String, :required => true

  	validates_presence_of :user
  	belongs_to :user
  	alias :creator :user
end
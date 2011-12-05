class Question
	include MongoMapper::Document

	key :title, String, required:true
  	key :body, String, required:true

  	belongs_to :creator, class_name:'User'
  	validates_presence_of :creator

  	many :answers, :dependent => :delete_all
end

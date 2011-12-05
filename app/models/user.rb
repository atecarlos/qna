class User
	include MongoMapper::Document
  	# Include default devise modules. Others available are:
  	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    attr_accessible :email, :password, :role, :password_confirmation

    key :role

    many :questions
    many :answers

    def moderator?
    	role == :moderator
    end
end

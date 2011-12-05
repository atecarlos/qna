class Ability
  include CanCan::Ability

  def initialize(user)
    restrict_only_edit_and_destroy_for Question, user
    restrict_only_edit_and_destroy_for Answer, user
  end

  private 
    def restrict_only_edit_and_destroy_for(klass, user)
        can [:read, :create], klass
        can [:edit, :destroy], klass do |instance|
            instance.creator.id == user.id || user.moderator?
        end
    end
end

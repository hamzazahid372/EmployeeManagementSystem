module Abilities
  module CommentAbility
    def define_comment_abilities_for_admin(user)
      can :manage, Comment, company_id: user.company_id
    end

    def define_comment_abilities_for_employee(user)
      can :manage, Comment, user_id: user.id, company_id: user.company_id
      can :read, Comment, company_id: user.company_id
    end
  end
end

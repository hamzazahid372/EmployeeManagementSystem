module Abilities
  module AttachmentAbility
    def define_attachment_abilities_for_admin(user)
      can :manage, Attachment, user_id: user.id, company_id: user.company_id
      can :destroy, Attachment, company_id: user.company_id
    end

    def define_attachment_abilities_for_employee(user)
      can :manage, Attachment, company_id: user.company_id
    end
  end
end

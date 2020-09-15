# frozen_string_literal: true

# Current attributes
class Current < ActiveSupport::CurrentAttributes
  attribute :company, :company_id
  resets { company = nil, company_id = nil }

  def company=(compny)
    super
    company = compny
    company_id = company.id
  end

  def company_id=(compny_id)
    super
    company_id = compny_id
    company = Company.find_by(id: compny_id)
  end
end

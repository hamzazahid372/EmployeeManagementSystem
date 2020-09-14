# frozen_string_literal: true

# Application Record Model
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  @is_multitenant = true

  def self.not_multitenant
    @is_multitenant = false
  end

  def self.multitenant?
    @is_multitenant
  end

  def self.inherited(subclass)
    super
    trace = TracePoint.new(:end) do |tp|
      if tp.self == subclass
        trace.disable
        default_scope { where(company_id: Company.current_id) } if subclass.multitenant?
      end
    end
    trace.enable
  end
end

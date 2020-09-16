# frozen_string_literal: true

# Application Record Model
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.not_multitenant
    @is_multitenant = false
  end

  def self.multitenant?
    @is_multitenant
  end

  def self.inherited(subclass)
    super
    subclass.instance_eval { @is_multitenant = true }

    trace = TracePoint.new(:end) do |tp|
      if tp.self == subclass
        trace.disable
        subclass.instance_eval do
          if subclass.multitenant?
            default_scope { where(company_id: Current.company_id) }
          end
        end
      end
    end
    trace.enable
  end
end

class Machine < ActiveRecord::Base
  attr_accessible :code, :yield_constant
  validates :code, presence: true
  validates :yield_constant, presence: true

  default_scope { where(tenant_id: Tenant.current_id) }
end

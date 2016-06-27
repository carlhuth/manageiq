class Vapp < VappOrTemplate
  default_scope { where(:template => false) }

  has_many :vms, :foreign_key => :vapp_id, :inverse_of => :vapp
end

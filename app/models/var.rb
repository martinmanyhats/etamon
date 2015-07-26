class Var < ActiveRecord::Base
  
  belongs_to :boiler, -> { readonly }
  has_and_belongs_to_many :mappings
  
end

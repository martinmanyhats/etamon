class Var < ActiveRecord::Base
  
  belongs_to :boiler, -> { readonly }
  has_and_belongs_to_many :mappings
  
  def uris
    mappings.map {|m| m.uri}
  end
  
  def paths
    mappings.map {|m| m.path}
  end
  
end

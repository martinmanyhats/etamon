class Mapping < ActiveRecord::Base
  
  belongs_to :boiler
  has_and_belongs_to_many :vars
  
  default_scope { order('path ASC') }
  
  def getFormattedValue
    Rails.logger.debug("!! getValue: #{path}")
    v = getValue
    case datatype
    when 'p'
    else
      v.to_s
    end
  end
  
  def getValue
    boiler.getVarWithURI(uri)
  end
  
end

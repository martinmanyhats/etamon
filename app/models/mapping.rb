class Mapping < ActiveRecord::Base
  
  belongs_to :boiler
  
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

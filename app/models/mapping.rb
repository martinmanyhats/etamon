class Mapping < ActiveRecord::Base
  
  belongs_to :boiler
  has_and_belongs_to_many :vars
  
  default_scope { order('path ASC') }
  
  def get_formatted_value
    Rails.logger.debug("!! get_formatted_value: #{path}")
    v = get_value
    case datatype
    when 'C'
      "#{v} °C"
    when 'k'
      "#{v} kg"
    when 'W'
      "#{v} kW"
    when 'B'
      "#{v} Bar"
    when 'P'
      "#{v} Pa"
    when '%'
      "#{v} %"
    else
      v.to_s
    end
  end
  
  def get_value
    boiler.get_value_with_URI(uri)
  end
  
end

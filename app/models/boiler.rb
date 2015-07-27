class Boiler < ActiveRecord::Base
  
  has_many :mappings, dependent: :destroy
  has_many :vars, dependent: :destroy
  has_many :datalogs, dependent: :destroy
  
  def api
    response = RestClient.get(url("/user/api"))
    if response.code != 200
      Rails.logger.debug("!! api: code #{response.code}")
      return "FAIL"
    end
    result = Nokogiri::HTML(response.to_str)
    Rails.logger.debug("!! api: result #{result.inspect}")
    Rails.logger.debug("!! api: api #{result.at_xpath('//eta/api/@version')}")
    result.at_xpath('//eta/api/@version')
  end
  
  def get_value_with_URI(uri)
    Rails.logger.debug("!! get_value_with_URI #{uri}")
    response = RestClient.get(url("/user/var/#{uri}"))
    if response.code != 200
      Rails.logger.debug(">> get_value_with_URI code #{response.code}")
      return "FAIL"
    end
    result = Nokogiri::HTML(response.to_str)
    Rails.logger.debug("!! get_value_with_URI result #{result.inspect}")
    Rails.logger.debug("!! get_value_with_URI strvalue #{result.at_xpath('//eta/value/@strvalue')}")
    result.at_xpath('//eta/value/@strvalue')
  end
  
  def url(path)
    "http://#{ipaddress}:#{port}#{path}"
  end
  
end

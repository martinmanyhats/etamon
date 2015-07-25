class Boiler < ActiveRecord::Base
  
  has_many :mappings, dependent: :destroy
  
  def api
    response = RestClient.get "http://#{ipaddress}:#{port}/user/api"
    if response.code != 200
      Rails.logger.debug("!! api: code #{response.code}")
      return "FAIL"
    end
    result = Nokogiri::HTML(response.to_str)
    Rails.logger.debug("!! api: result #{result.inspect}")
    Rails.logger.debug("!! api: api #{result.at_xpath('//eta/api/@version')}")
    result.at_xpath('//eta/api/@version')
  end
  
  def getVarWithURI(uri)
    Rails.logger.debug("!! getValueFromURI #{uri}")
    response = RestClient.get "http://#{ipaddress}:#{port}/user/var/#{uri}"
    if response.code != 200
      Rails.logger.debug(">> getValueFromURI code #{response.code}")
      return "FAIL"
    end
    result = Nokogiri::HTML(response.to_str)
    Rails.logger.debug("!! getValueFromURI result #{result.inspect}")
    Rails.logger.debug("!! getValueFromURI strvalue #{result.at_xpath('//eta/value/@strvalue')}")
    result.at_xpath('//eta/value/@strvalue')
  end
  
end

class Boiler < ActiveRecord::Base
  
  has_many :mappings, dependent: :destroy
  has_many :vars, dependent: :destroy
  has_many :datalogs, dependent: :destroy
  
  def api
    begin
      response = RestClient::Request.execute(method: :get, url: url("/user/api"), open_timeout: 3, read_timeout: 3)
    rescue
      Rails.logger.debug(">> get_value_with_URI exception")
      # No point allowing subsequent queries to block us.
      raise "get_value_with_URI EXCEPTION"
    end
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
    Rails.logger.debug("!! get_value_with_URI #{shortname} #{uri}")
    begin
      response = RestClient::Request.execute(method: :get, url: url("/user/var/#{uri}"), open_timeout: 3, read_timeout: 3)
    rescue
      Rails.logger.debug(">> get_value_with_URI exception")
      # No point allowing subsequent queries to block us.
      raise "get_value_with_URI EXCEPTION"
    end
    if response.code != 200
      Rails.logger.debug(">> get_value_with_URI code #{response.code}")
      return "FAIL"
    end
    result = Nokogiri::HTML(response.to_str)
    Rails.logger.debug("!! get_value_with_URI result #{result.inspect}")
    Rails.logger.debug("!! get_value_with_URI strvalue #{result.at_xpath('//eta/value/@strvalue')}")
    result.at_xpath('//eta/value/@strvalue')
  end
  
  def get_value_with_path(path)
    Rails.logger.debug("!! get_value_with_path #{shortname} #{path}")
    get_value_with_URI(mappings.find_by(path: path).uri)
  end
  
  def url(path)
    "http://#{ipaddress}:#{port}#{path}"
  end
  
end

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
  
  def var!(var)
    Rails.logger.debug("!! var! #{var.inspect}")
    begin
      response = RestClient.get(url("/user/vars/#{var.name}"))
      Rails.logger.debug("!! var! response #{response.inspect}")
      if response.code != 200
        Rails.logger.debug(">> var! code #{response.code}")
        return false
      else
        return true
      end
    rescue => e
      Rails.logger.debug(">> var! exception #{e.inspect}")
    end
    return false
  end
  
  def create_var(var)
    Rails.logger.debug("!! create_var #{var.inspect}")
    begin
      response = RestClient.put(url("/user/vars/#{var.name}"), nil, :content_type => 'text/plain')
      Rails.logger.debug("!! create_var response #{response.inspect}")
      if response.code != 201
        Rails.logger.debug(">> create_var code #{response.code}")
      end
    rescue => e
      Rails.logger.debug(">> create_var exception #{e.inspect}")
    end
  end
  
  def destroy_var(var)
    Rails.logger.debug("!! destroy_var #{var.inspect}")
    begin
      response = RestClient.delete(url("/user/vars/#{var.name}"))
      Rails.logger.debug("!! destroy_var response #{response.inspect}")
      if response.code != 200
        Rails.logger.debug(">> destroy_var code #{response.code}")
      end
    rescue => e
      Rails.logger.debug(">> destroy_var exception #{e.inspect}")
    end
  end
  
  def set_var(var)
    create_var(var) unless var!(var)
  end
  
  def get_var(var)
    Rails.logger.debug("!! get_var #{var.inspect}")
    begin
      response = RestClient.get(url("/user/vars/#{var.name}"))
      if response.code != 200
        Rails.logger.debug(">> get_var code #{response.code}")
        return "FAIL"
      end
    rescue => e
      Rails.logger.debug(">> get_var exception #{e.inspect}")
    end
  end
  
  def url(path)
    "http://#{ipaddress}:#{port}#{path}"
  end
  
end

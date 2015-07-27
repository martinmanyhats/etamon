class Var < ActiveRecord::Base
  
  belongs_to :boiler, -> { readonly }
  has_and_belongs_to_many :mappings
  
  def varset!
    Rails.logger.debug("!! varset! #{self.inspect}")
    begin
      response = RestClient.get(url("/user/vars/#{name}"))
      Rails.logger.debug("!! varset! response #{response.inspect}")
      if response.code != 200
        Rails.logger.debug(">> varset! code #{response.code}")
        return false
      else
        return true
      end
    rescue => e
      Rails.logger.debug(">> varset! exception #{e.inspect}")
    end
    return false
  end
  
  def create_varset
    Rails.logger.debug("!! create_varset #{self.inspect}")
    begin
      response = RestClient.put(boiler.url("/user/vars/#{name}"), nil, :content_type => 'text/plain')
      Rails.logger.debug("!! create_varset response #{response.inspect}")
      if response.code != 201
        Rails.logger.debug(">> create_varset code #{response.code}")
      end
    rescue => e
      Rails.logger.debug(">> create_varset exception #{e.inspect}")
    end
  end
  
  def destroy_varset
    Rails.logger.debug("!! destroy_varset #{self.inspect}")
    begin
      response = RestClient.delete(boiler.url("/user/vars/#{name}"))
      Rails.logger.debug("!! destroy_varset response #{response.inspect}")
      if response.code != 200
        Rails.logger.debug(">> destroy_varset code #{response.code}")
      end
    rescue => e
      Rails.logger.debug(">> destroy_varset exception #{e.inspect}")
    end
  end
  
  def update_varset
    create_varset unless varset!
    current_mappings = get_varset_mappings
    # Work out the changes we need to make.
    (mappings - current_mappings).each {|m| add_mapping_to_varset(m)}
    (current_mappings - mappings).each {|m| remove_mapping_from_varset(m)}
 end
  
  def add_mapping_to_varset(mapping)
    url = boiler.url("/user/vars/#{name}/#{mapping.uri}")
    Rails.logger.debug("!! add_mapping_to_varset #{mapping.path} #{name} #{url}")
    begin
      response = RestClient.put(url, nil, :content_type => 'text/plain')
      Rails.logger.debug("!! create_varset response #{response.inspect}")
      if response.code != 201
        Rails.logger.debug(">> create_varset code #{response.code}")
      end
    rescue => e
      Rails.logger.debug(">> create_varset exception #{e.inspect}")
    end
  end
  
  def remove_mapping_from_varset(mapping)
    url = boiler.url("/user/vars/#{name}/#{mapping.uri}")
    Rails.logger.debug("!! remove_mapping_from_varset #{mapping.path} #{name} #{url}")
    begin
      response = RestClient.delete(url)
      Rails.logger.debug("!! remove_mapping_from_varset response #{response.inspect}")
      if response.code != 200
        Rails.logger.debug(">> remove_mapping_from_varset code #{response.code}")
      end
    rescue => e
      Rails.logger.debug(">> remove_mapping_from_varset exception #{e.inspect}")
    end
  end
  
  def get_varset_mappings
    Rails.logger.debug("!! remove_mapping_from_varset #{self.inspect}")
    begin
      response = RestClient.get(boiler.url("/user/vars/#{name}"))
      if response.code != 200
        Rails.logger.debug(">> get_varset_mappings code #{response.code}")
        return array('FAIL')
      end
      result = Nokogiri::HTML(response.to_str)
      Rails.logger.debug("!! get_varset_mappings result #{result.inspect}")
      return result.xpath('//variable/@uri').map {|n| Mapping.find_by(uri: n.value)}
    rescue => e
      Rails.logger.debug(">> get_varset_mappings exception #{e.inspect}")
    end
    return array('FAIL')
  end
  
  def uris
    mappings.map {|m| m.uri}
  end
  
  def paths
    mappings.map {|m| m.path}
  end
  
end

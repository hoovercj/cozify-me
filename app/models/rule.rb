require 'coderay'

class Rule < ActiveRecord::Base
  belongs_to :user

  # Takes a cozify rule written in python
  # and parses out important information from it
  def self.parse_code code
    {
      rule_type: parse_rule_type(code),
      name: parse_name(code),
      description: parse_description(code),
      summary: parse_summary(code),
      capabilities: parse_capabilities(code),
      code: code
    }
  end
  
  # Takes a hash of parameters and merges them
  # with the hash obtained by parsing the code
  # found within.
  # Parameters passed in as an argument override
  # the values found by parsing the code
  def self.create_params parameters
    parse_code(parameters[:code]).each do |key, value|
      if parameters[key].blank?
        parameters[key] = value 
      end
    end
    parameters
  end
  
  # Returns an html formatted string with
  # self-contained styling for python code
  def code_html
    CodeRay.scan(self.code, :python).div().html_safe
  end
  
  def username
    if self.user
      self.user.name
    else
      "anonymous"
    end
  end
  
  def capabilities_arr
     self.capabilities ? self.capabilities.gsub(/\[|\]|\s|\"/,'').split(/,/) : nil
  end
  
  def self.parse_rule_type code
      matched = /type\s*=\s*(['"]+.*['"]+)/.match(code)
      matched ? matched[1] : nil
  end
  
  def self.parse_name code
      matched = /name\s*=\s*(['"]+.*['"]+)/.match(code)
      matched ? matched[1] : nil
  end
    
  def self.parse_description code
      matched = /description\s*=\s*(['"]+.*['"]+)/.match(code)
      matched ? matched[1] : nil
  end
    
  def self.parse_summary code
       matched = /summary\s*=\s*(['"]+.*['"]+)/.match(code)
       matched ? matched[1] : nil
  end
    
  def self.parse_capabilities code
      matched = code.scan(/capabilities\s*=\s*\[(.*)\]/).try(:flatten)
      matched ? matched : []
  end
end

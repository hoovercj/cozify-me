require 'coderay'

class Rule < ActiveRecord::Base
  def self.parse_code code
    parsed = {
      rule_type: parse_rule_type(code),
      name: parse_name(code),
      description: parse_description(code),
      summary: parse_summary(code),
      capabilities: parse_capabilities(code),
      code: code
    }
  end
  
  def code_html
      CodeRay.scan(self.code, :python).div().html_safe
  end
  
  def capabilities_arr
     self.capabilities.gsub(/\[|\]|\s|\"/,'').split(/,/)
  end
  
  def self.parse_rule_type code
      /type\s*=\s*(['"]+.*['"]+)/.match(code)[1]
  end
  
  def self.parse_name code
      /name\s*=\s*(['"]+.*['"]+)/.match(code)[1]
  end
    
  def self.parse_description code
      /description\s*=\s*(['"]+.*['"]+)/.match(code)[1]
  end
    
  def self.parse_summary code
       /summary\s*=\s*(['"]+.*['"]+)/.match(code)[1]
  end
    
  def self.parse_capabilities code
      code.scan(/capabilities\s*=\s*\[(.*)\]/).try(:flatten)
  end
end

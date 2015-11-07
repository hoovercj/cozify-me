class User < ActiveRecord::Base
  has_many :rules
    
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
  
  def author_of?(rule_id)
      self.rules.find_by_id(rule_id)
  end
end
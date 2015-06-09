class User < ActiveRecord::Base

  def self.create_from_omniauth(auth)
    self.create(uid: auth['uid'], name: auth.info.name, email: auth.info.email, image_url: auth.info.image)
  end
  
end
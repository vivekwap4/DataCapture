# require 'aws-sdk-s3'
require 'aws-sdk'

class Authentication < ActiveRecord::Base
  validates_uniqueness_of :email, :message=> "Email already in Use"
  before_save {|authentication| authentication.email=authentication.email.downcase}

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing_medium.jpg"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def self.create_user(attributes)
    attributes[:session_token] = SecureRandom.base64(20)
    attributes[:access] = "user"
    Authentication.create(attributes)
  end

end

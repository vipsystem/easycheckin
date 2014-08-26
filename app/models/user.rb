class User < ActiveRecord::Base

  has_secure_password

  validates_presence_of :name, :email, :phone_number, :address, :zip_code, :city, :state
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :phone_number, length: { is: 10 }
  private


end
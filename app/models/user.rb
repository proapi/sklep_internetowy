# encoding: utf-8

class User < ActiveRecord::Base

  has_many :articles
  has_many :messages

  acts_as_authentic do |c|
    c.login_field = :email
    c.validate_login_field false
  end

  def full_name
    string = last_name.capitalize + " " + name.capitalize

    if string.blank?
      string = email.slice(0..(email.index("@")-1)).capitalize
    end

    string
  end

end

# encoding: utf-8

class Client < ActiveRecord::Base

  has_many :orders, :conditions => ["status > ?", 0]
  has_many :order_items, :through => :order
  has_many :messages

  validates_presence_of :street, :city, :building_no, :code, :telephone
  validates_presence_of :name, :last_name, :if => Proc.new { |client| client.private }
  validates_presence_of :company, :nip, :if => Proc.new { |client| !client.private }
  validates_acceptance_of :agreement, :accept => true
  validates :email, presence: true, email: true, confirmation: true

  acts_as_authentic do |c|
    c.login_field = :email
    c.validate_login_field false
  end

  def full_name
    if private?
      string = last_name.capitalize + " " + name.capitalize
    else
      string = company
    end

    if string.blank?
      string = email.slice(0..(email.index("@")-1)).capitalize
    end

    string
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    OrderMailer.password_reset_instructions(self).deliver
  end

end
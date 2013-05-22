class Message < ActiveRecord::Base
  attr_accessible :name, :email, :content, :title, :client_id

  belongs_to :client
  belongs_to :user

  validates_presence_of :name, :title
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_length_of :content, :maximum => 500

  after_save :deliver_message

  private
  def deliver_message
    OrderMailer.client_message(self).deliver
  end
end

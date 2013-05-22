# encoding: utf-8

class Producer < ActiveRecord::Base

  has_many :products, :dependent => :nullify

  validates_presence_of :name

end

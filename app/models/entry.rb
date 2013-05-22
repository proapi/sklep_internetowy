# encoding: utf-8

class Entry < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :title, :body
  validates_length_of :meta_description, maximum: 255
  validates_length_of :meta_keywords, maximum: 255
  validates_length_of :meta_title, maximum: 255
end

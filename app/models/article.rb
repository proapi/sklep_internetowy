# encoding: utf-8

class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_one :photo

  #nested forms
  accepts_nested_attributes_for :photo, :reject_if => lambda { |a| a.values.all?(&:blank?) }, :allow_destroy => true

  default_scope :include => [:user, :photo], :order => "updated_at DESC"
end

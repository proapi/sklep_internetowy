# encoding: utf-8

class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :producer
  has_and_belongs_to_many :categories
  has_one :photo
  has_many :archives
  has_and_belongs_to_many :relations

  #nested forms
  accepts_nested_attributes_for :photo, :reject_if => lambda { |a| a.values.all?(&:blank?) }, :allow_destroy => true

  validates_length_of :meta_description, maximum: 255
  validates_length_of :meta_keywords, maximum: 255
  validates_length_of :meta_title, maximum: 255

  before_save :discard_promotion
  before_save :calculate_final_price

  scope :visible, where(:visible => true)

  def calculate_final_price
    if is_promotion
      self.final_price = (promotion_price)
    elsif !self.discount.blank? && self.discount > 0
      self.final_price = (price-(price*discount/100))
    else
      self.final_price = (price)
    end
  end

  def self.random
    if (c = (Product.count(:conditions => "visible is true") - 2)) != 0
      Product.visible.limit(2).offset(rand(c))
    end
  end

  def self.bestsellers
    Product.visible.limit(2).order('hits_quantity desc')
  end

  def self.random_to_basket
    if (c = (Category.find(22).products.visible.count - 3)) != 0
      Category.find(22).products.visible.limit(3).offset(rand(c))
    end
  end

  def promotion?
    self.is_promotion
  end

  class << self
    #metoda klasowa zamiast scope, potrzebna do wyciągania we frontend dla klientów sklepu
    def only_visible
      where(visible: true)
    end
  end

  private
  def discard_promotion
    unless self.visible?
      self.is_promotion = false
      self.promotion_price = 0
      self.promotion_text = nil
    end
  end

end
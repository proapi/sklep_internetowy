# encoding: utf-8

class Category < ActiveRecord::Base
  has_and_belongs_to_many :products

  acts_as_nested_set

  default_scope :order => "list_order, name"
  scope :main, where("parent_id is null")

  validates_presence_of :name, :list_order
  validates_numericality_of :list_order

  protected

  def validate
    unless self.id == nil
      errors.add(:parent_id, "Kategoria nie może być własnym rodzicem.") if self.id == self.parent_id
      errors.add(:parent_id, "Kategoria nie może mieć za rodzica własnego potomka.") if self.parent.ancestors.include?(self) unless self.parent == nil
    end
  end

end

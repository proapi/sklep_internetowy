# encoding: utf-8

class Photo < ActiveRecord::Base

  belongs_to :product
  belongs_to :article

  # konfiguracja gem'u paperclip do zarządzania załącznikami plikowymi do modelu
  has_attached_file :image,
                    :url => "/system/paperclip/:class_:id_:style.:extension",
                    :path => ":rails_root/public/system/paperclip/:class_:id_:style.:extension",
                    :styles => {
                        :thumb => ["100x100>", :png],
                        :medium => ["540x405>", :png],
                        :original => ["640x480>", :png]}
  validates_attachment_size :image, :less_than => 1.megabytes, :if => Proc.new { |location| location.image.exists? }

  #wyciągnięcie wszystkich zdjęć do rotatora
  scope :rotator, where('rotator is true').order("rotator_order")

  def resize(size)
    self.image = self.image.resize size
  end

end

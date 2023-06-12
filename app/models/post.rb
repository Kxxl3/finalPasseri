require 'mime/types'

class Post < ApplicationRecord
  acts_as_votable

  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  has_many :comments
  has_one_attached :file
  has_one_attached :photo
  belongs_to :user

  validates :title, :file, :photo, presence: true
  validates :title, length: { minimum: 0, maximum: 60 }
  validate :validar_imagen
  validate :validar_cancion

  private

  def validar_imagen
    if photo.attached? && !photo.image?
      errors.add(:photo, "Debe ser una imagen válida")
    end
  end

  def validar_cancion
    if file.attached? && !es_cancion?(file)
      errors.add(:file, "Debe ser un archivo de música válido")
    end
  end

  def es_cancion?(archivo)
    MIME::Types.type_for(archivo.blob.filename.to_s).any? { |tipo| tipo.media_type == 'audio' }
  end

end

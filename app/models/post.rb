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
    if photo.attached? && !es_imagen?(photo)
      errors.add(:photo, "Debe ser una imagen válida")
    end
  end

  def validar_cancion
    if file.attached? && !es_cancion?(file)
      errors.add(:file, "Debe ser un archivo de música válido")
    end
  end

  def es_cancion?(archivo)
  extension = File.extname(archivo.blob.filename.to_s)[1..-1] # Obtener la extensión del archivo sin el punto inicial
  tipos_audio = %w[mp3 wav ogg flac ] # Lista de extensiones de audio válidas
  tipos_audio.include?(extension.downcase) # Comprobar si la extensión del archivo está en la lista de tipos de audio
  end

  def es_imagen?(archivo)
    extension = File.extname(archivo.blob.filename.to_s)[1..-1] # Obtiene la extensión del archivo sin el punto inicial
    tipos_imagen = %w[jpg jpeg png gif raw] # Lista de extensiones de imagen válidas
    tipos_imagen.include?(extension.downcase) # Comprueba si la extensión del archivo está en la lista de tipos de imagen
  end
end

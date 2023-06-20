class ErrorsController < ApplicationController
    def not_found
      # Mostrar  mensaje de error 
      render 'errors/not_found', status: :not_found
    end
  end
  
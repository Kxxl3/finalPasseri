class ErrorsController < ApplicationController
    def not_found
      # Puedes mostrar un mensaje de error o redirigir al usuario a otra página
      render 'errors/not_found', status: :not_found
    end
  end
  
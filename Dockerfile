FROM render/ruby:3.0

RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g yarn

RUN mkdir /app_passeri
WORKDIR /app_passeri

# Copiar el Gemfile y el Gemfile.lock al contenedor
COPY Gemfile Gemfile.lock ./

# Instala las dependencias de la aplicación
RUN bundle install --without development test

# Agrega la ruta de ejecutables de bundler al PATH
ENV PATH="/app_passeri/bin:${PATH}"

# Expone el puerto en el que tu aplicación escucha
EXPOSE 8080

# Define el comando para iniciar tu aplicación
CMD ["bundle", "exec", "rails", "server", "-p", "8080", "-b", "0.0.0.0"]

FROM ruby

RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g yarn

RUN mkdir /app_passeri
WORKDIR /app_passeri

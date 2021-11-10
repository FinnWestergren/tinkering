FROM node:12-bullseye

RUN apt-get update \
 && apt-get install -y sudo

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

RUN sudo apt-get update
RUN sudo apt-get -y install curl

RUN sudo curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
RUN sudo gunzip elm.gz
RUN sudo chmod +x elm
RUN sudo mv elm /usr/local/bin/
RUN sudo npm install http-server -g
RUN sudo npm install elm-live -g

COPY . .
RUN sudo elm make ./src/Main.elm --output=static/main.js

CMD ["http-server --port 8080 --proxy http://localhost:8080?"]
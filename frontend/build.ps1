elm make ./src/Main.elm --output=static/main.js
http-server --port 3001 --proxy http://localhost:3001?
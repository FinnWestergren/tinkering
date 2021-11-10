import { createServer } from 'http';
import http from 'http';

const hostname = '127.0.0.1';
const port = 3000;

const route = (url) => {
    console.log(url);
    return {test: 1235};
}

const server = createServer((req, res) => {
  const result = route(req.url);
  res.setHeader('Content-Type', 'text/json');
  res.statusCode = 200;
  res.end(JSON.stringify(result));
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

import { createServer, IncomingMessage, ServerResponse } from 'http';
import { ErrorNames, NotFoundError, ServerError } from './customError';
import * as PresentationService from './presentationService';
import * as Path from 'path';
import * as FileSystem from 'fs';

const hostname = '127.0.0.1';
const port = 3000;

const POST_LIST = "postlist";
const POST = "post";
const IMAGE = "img";

const imageBase = "image-sets";

const server = createServer((req: IncomingMessage, res: ServerResponse) => {
    res.setHeader("Access-Control-Allow-Origin", "*")
    res.setHeader("Cache-Control", "public, max-age=31536000")
    res.setHeader("Last-Modified", "Wed, 21 Oct 2015 07:28:00 GMT")
    if (req.method !== 'GET') {
        res.statusCode = 501;
        res.setHeader('Content-Type', 'text/plain');
        return res.end('Method not implemented');
    }
    try {
        route(req.url, res);
    }
    catch (error) {
        res.setHeader('Content-Type', 'text/json');
        console.log(error.message + 'hi');
        handleError(error, res);
    }
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

const route: (url: string, res: ServerResponse) => void = (url, res) => {
    var urlSplit = url.toLowerCase().split('/');
    var base = urlSplit[1];
    switch (base) {
        case POST_LIST:
            stringRes(PresentationService.getPostList(), res);
            return;
        case POST:
            var postId = urlSplit[2];
            stringRes(PresentationService.getPost(postId), res);
            return;
        case IMAGE:
            imgRes(url.replace(`/${base}/`, ''), res);
            return;
        default:
            throw new NotFoundError();
    }
}


const handleError = (error: Error, res: ServerResponse) => {
    console.error(error.message);
    switch(error.name){
        case (ErrorNames.NotFound):
        case (ErrorNames.Server):
            break;
        default:
            error = new ServerError();
    }
    res.statusCode = Number.parseInt(error.name.substring(0,3), 10);
    res.end(`{"error": "${error.message}"}`);
}

const stringRes = (json: Object, res: ServerResponse) => {
    res.setHeader('Content-Type', 'text/json');
    res.statusCode = 200;
    res.end(JSON.stringify(json));
}

const imgRes = (request: string, res: ServerResponse) => {
    const baseName = '\\' + Path.basename(__dirname);
    const setName = 'shit-set';
    const backDir = __dirname.replace(baseName, '');
    const file = Path.join(backDir, imageBase, setName, request) + '.png';
    const stream = FileSystem.createReadStream(file);
    stream.on('open', () => {
        res.setHeader('Content-Type', 'image/png');
        stream.pipe(res)
    });
    stream.on('error', (err) => {
        handleError(err, res);
    });
}

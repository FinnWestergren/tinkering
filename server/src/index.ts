import { createServer } from 'http';
import { ErrorNames, NotFoundError, ServerError } from './CustomErrors';
import * as Presentation from './presentation';

const hostname = '127.0.0.1';
const port = 3000;

type Request = { url: string; }
type Response = { setHeader: (arg0: string, arg1: string) => void; statusCode: number; end: (arg0?: string) => void; }

const route: (url: string) => string = (url) => {
    var urlSplit = url.toLowerCase().split('/');
    switch (urlSplit[1]) {
        case "postlist":
            return JSON.stringify(Presentation.getPostList());
        case "post":
        case "posts":
            return JSON.stringify(Presentation.getPost(urlSplit[2]));
        default:
            throw new NotFoundError(url);
    }
}

const server = createServer((req: Request, res: Response) => {
    res.setHeader('Content-Type', 'text/json');
    res.setHeader("Access-Control-Allow-Origin", "*")
    try {
        const result = route(req.url);
        res.statusCode = 200;
        res.end(result);
    }
    catch (error) {
        handleError(error, res);
    }
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

const handleError = (error: Error, res: Response) => {
    console.error(error.message);
    console.log(error.name);
    switch(error.name){
        case (ErrorNames.NotFound):
        case (ErrorNames.Server):
            break;
        default:
            error = new ServerError("Unknown Error Occured");
    }
    console.log(error.name);
    res.statusCode = Number.parseInt(error.name.substring(0,3), 10);
    res.end(`{"error": "${error.message}"}`);
}


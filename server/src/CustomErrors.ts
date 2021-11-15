const NotFound = "404 - Page Not Found";
const Server = "500 - Server Error";

export const ErrorNames = {
    Server,
    NotFound
}

export class NotFoundError extends Error {
    constructor(url: string) {
      super(`Page Not Found: ${url}`) // (1)
      this.name = NotFound; // (2)
    }
  }


export class ServerError extends Error {
  constructor(message: string) {
    super(message); // (1)
    this.name = Server; // (2)
  }
}
const NotFound = "404 - Page Not Found";
const Server = "500 - Server Error";

export const ErrorNames = {
    Server,
    NotFound
}

export class NotFoundError extends Error {
    constructor(message?: string) {
      super(message ?? 'Page Not Found') // (1)
      this.name = NotFound; // (2)
    }
  }


export class ServerError extends Error {
  constructor(message?: string) {
    super(message ?? 'Unknown Error Occured'); // (1)
    this.name = Server; // (2)
  }
}
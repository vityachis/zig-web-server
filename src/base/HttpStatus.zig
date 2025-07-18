const std = @import("std");

const HttpStatus = enum(u16) {
    // 2xx:
    ok = 200, // 200 OK
    created = 201, // 201 Created
    accepted = 202, // 202 Accepted
    noContent = 204, // 204 No Content

    // 3xx:
    movedPermanently = 301, // 301 Moved Permanently
    found = 302, // 302 Found

    // 4xx:
    badRequest = 400, // 400 Bad Request
    unauthorized = 401, // 401 Unauthorized
    forbidden = 403, // 403 Forbidden
    notFound = 404, // 404 Not Found
    unprocessableEntity = 422, // 422 Unprocessable Entity
    tooManyRequests = 429, // 429 Too Many Requests

    // 5xx:
    serverError = 500, // 500 Internal Server Error
};

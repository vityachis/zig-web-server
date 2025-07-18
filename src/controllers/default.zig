const std = @import("std");
const http = std.http;

pub fn index(req: *http.Server.Request) !void {
    _ = req;
}
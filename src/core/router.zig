const std = @import("std");
const http = std.http;

pub fn run(req: *http.Server.Request) !void {
    try req.respond("Hello, Zig!", std.http.Server.Request.RespondOptions{});
}
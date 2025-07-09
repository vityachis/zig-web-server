const std = @import("std");

pub const Action = enum {
    index,
    notFound,
};

pub fn index(req: *std.http.Server.Request) !void {
    try req.respond("Hello, world!", std.http.Server.Request.RespondOptions{});
}

pub fn notFound(req: *std.http.Server.Request) !void {
    try req.respond("#404: Not found.", std.http.Server.Request.RespondOptions{
        .status = std.http.Status.not_found
    });
}
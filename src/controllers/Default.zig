const std = @import("std");
const http = std.http;

pub const Default = struct {
    pub fn create(req: *http.Server.Request) !void {
        _ = req;
    }

    pub fn read(req: *http.Server.Request) !void {
        _ = req;
    }

    pub fn update(req: *http.Server.Request) !void {
        _ = req;
    }

    pub fn delete(req: *http.Server.Request) !void {
        _ = req;
    }

    pub fn list(req: *http.Server.Request) !void {
        try req.respond("Hello, Zig!", std.http.Server.Request.RespondOptions{});
    }
};

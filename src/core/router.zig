const std = @import("std");
const http = std.http;
const routes = @import("../routes/main.zig");
const Route = @import("../base/Route.zig").Route;

pub fn run(req: *http.Server.Request) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var list = std.ArrayList(Route).init(allocator);
    defer list.deinit();

    try routes.run(&list, req);
}
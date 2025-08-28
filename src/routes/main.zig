const std = @import("std");
const http = std.http;
const defaultRoutes = @import("default.zig");
const Route = @import("../base/Route.zig").Route;

pub fn run(list: *std.ArrayList(Route), req: *http.Server.Request) !void {
    const routes = try routeList(list);

    for (routes.*.items) |route| {
        if (std.mem.eql(u8, route.path, req.head.target)) {
            try route.controller.list(req);
            break;
        }
    }
}

fn routeList(routes: *std.ArrayList(Route)) !*std.ArrayList(Route) {
    // default.zig
    const default = defaultRoutes.routes();

    try routes.appendSlice(&default);
    return routes;
}
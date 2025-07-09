const std = @import("std");
const d = @import("debug.zig");
const a = @import("actions.zig");

pub fn main() !void {
    d.pMessage("============= RUN =============");

    const address = std.net.Address.parseIp4("0.0.0.0", 8080) catch |err| {
        d.pError("std.net.Address.parseIp4()", err);
        return;
    };

    var server = address.listen(std.net.Address.ListenOptions{}) catch |err| {
        d.pError("address.listen()", err);
        return;
    };
    defer server.deinit();

    d.pMessage("Listening 0.0.0.0:8080...");
    while (true) {
        try handleConnection(try server.accept());
    }
}

fn handleConnection(conn: std.net.Server.Connection) !void {
    defer conn.stream.close();

    var buffer: [1024]u8 = undefined;
    var httpServer = std.http.Server.init(conn, &buffer);
    var req = httpServer.receiveHead() catch |err| {
        if (err == std.http.Server.ReceiveHeadError.HttpConnectionClosing) {
            d.pInfo("httpServer.receiveHead()", "The client sent 0 bytes of headers before closing the stream");
            return;
        } else {
            d.pError("httpServer.receiveHead()", err);
            return;
        }
    };

    try router(&req);
}

fn router(req: *std.http.Server.Request) !void {
    const url: []const u8 = req.head.target;
    const path: []const u8 = url[1..];
    const action: a.Action = whichAction(path);
    switch (action) {
        a.Action.index => try a.index(req),
        else => try a.notFound(req),
    }
}

fn whichAction(path: []const u8) a.Action {
    if (path.len == 0 or std.mem.eql(u8, path, "index")) return .index;
    return .notFound;
}

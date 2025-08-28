const std = @import("std");
const router = @import("router.zig");
const d = @import("debug.zig");
const net = std.net;
const http = std.http;
const mem = std.mem;
const fs = std.fs;

pub fn run() !void {
    const address = net.Address.parseIp4("0.0.0.0", 8080) catch |err| {
        d.pError("net.Address.parseIp4()", err);
        return;
    };

    var server = address.listen(net.Address.ListenOptions{}) catch |err| {
        d.pError("address.listen()", err);
        return;
    };
    defer server.deinit();

    d.pMessage("Listening 0.0.0.0:8080...");
    while (true) {
        try handleConnection(try server.accept());
    }
}

fn handleConnection(conn: net.Server.Connection) !void {
    defer conn.stream.close();

    var buffer: [1024]u8 = undefined;
    var httpServer = http.Server.init(conn, &buffer);
    var req = httpServer.receiveHead() catch |err| {
        if (err == http.Server.ReceiveHeadError.HttpConnectionClosing) {
            d.pInfo("httpServer.receiveHead()", "The client sent 0 bytes of headers before closing the stream");
            return;
        } else {
            d.pError("httpServer.receiveHead()", err);
            return;
        }
    };

    const path: []const u8 = getRequestPath(req.head.target);
    if (isRequestForStatic(path)) {
        sendStatic(path, &req);
        return;
    }

    try router.run(&req);
}

fn getRequestPath(uri: []const u8) []const u8 {
    const index: ?usize = mem.indexOf(u8, uri, "?");
    return if (index) |i| uri[0..i] else uri;
}

fn isRequestForStatic(path: []const u8) bool {
    if (path.len == 1 or !isSafePath(path)) {
        return false;
    }

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const pathToFile = getStaticFilePath(allocator, path) catch { return false; };
    defer allocator.free(pathToFile);

    d.pDebug("getStaticFilePath()", pathToFile);
    fs.cwd().access(pathToFile, fs.File.OpenFlags{}) catch |err| {
        d.pError("fs.cwd().access()", err);

        return false;
    };

    return true;
}

fn isSafePath(path: []const u8) bool {
    return !mem.containsAtLeast(u8, path, 1, "..");
}

fn sendStatic(path: []const u8, req: *http.Server.Request) void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const pathToFile = getStaticFilePath(allocator, path) catch { return; };
    defer allocator.free(pathToFile);

    const staticFile = fs.cwd().openFile(pathToFile, fs.File.OpenFlags{}) catch |openFileError| {
        d.pError("fs.cwd().openFile()", openFileError);
        req.respond("#500 Internal Server Error", http.Server.Request.RespondOptions{
            .status = http.Status.internal_server_error
        }) catch |respondError| {
            d.pError("req.respond()", respondError);
            return;
        };

        return;
    };
    defer staticFile.close();

    const fileSize = staticFile.getEndPos() catch |err| {
        d.pError("staticFile.getEndPos()", err);
        return;
    };

    const buffer = allocator.alloc(u8, fileSize) catch |err| {
        d.pError("allocator.alloc()", err);
        return;
    };

    defer allocator.free(buffer);

    const bytes = staticFile.readAll(buffer) catch |err| {
        d.pError("staticFile.readAll()", err);
        return;
    };

    req.respond(buffer[0..bytes], http.Server.Request.RespondOptions{}) catch |err| {
        d.pError("req.respond()", err);
        return;
    };
}

fn getStaticFilePath(allocator: mem.Allocator, path: []const u8) ![]const u8 {
    const pathToFile = mem.join(allocator, "", &.{"static", path}) catch |err| {
        d.pError("allocator.alloc()", err);
        return err;
    };

    return pathToFile;
}

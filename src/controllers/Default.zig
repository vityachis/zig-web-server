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
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        defer _ = gpa.deinit();

        var indexFile = try std.fs.cwd().openFile("./templates/default/index.html", .{});
        defer indexFile.close();

        const allocator = gpa.allocator();
        const fileSize = try indexFile.getEndPos();
        const buffer = try allocator.alloc(u8, fileSize);
        defer allocator.free(buffer);

        const bytes = try indexFile.readAll(buffer);

        try req.respond(buffer[0..bytes], std.http.Server.Request.RespondOptions{});
    }
};
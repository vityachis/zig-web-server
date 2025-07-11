const std = @import("std");
const server = @import("server.zig");
const d = @import("debug.zig");

pub fn run() !void {
    try server.run();
}


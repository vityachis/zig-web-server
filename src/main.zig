const std = @import("std");
const d = @import("debug.zig");
const app = @import("app.zig");

pub fn main() !void {
    d.pMessage("============= RUN =============");
    try app.run();
}

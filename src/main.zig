const std = @import("std");
const d = @import("core/debug.zig");
const app = @import("core/app.zig");

pub fn main() !void {
    d.pMessage("============= RUN =============");
    try app.run();
}

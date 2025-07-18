const std = @import("std");
const dt = @import("../base/DateTime.zig");

pub const User = struct {
    id: u32,
    email: []const u8,
    name: []const u8,
    password: []const u8,
    created_dt: dt.DateTime,
    updated_dt: dt.DateTime,
};
const std = @import("std");
const dateTime = @import("../base/DateTime.zig").DateTime;

pub const User = struct {
    id: u32,
    email: []const u8,
    name: []const u8,
    password: []const u8,
    created_dt: dateTime,
    updated_dt: dateTime,
};
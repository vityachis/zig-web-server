const std = @import("std");
const u = @import("../models/User.zig");

pub fn findOne(id: u32) !u.User {
    _ = id;
}
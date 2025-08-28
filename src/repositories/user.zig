const std = @import("std");
const userModel = @import("../models/User.zig").User;

pub fn findOne(id: u32) !userModel {
    _ = id;
}
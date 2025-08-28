const std = @import("std");
const UserModel = @import("../models/User.zig").User;

pub fn findOne(id: u32) !UserModel {
    _ = id;
}
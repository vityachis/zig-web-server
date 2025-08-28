const std = @import("std");
const Controller = @import("../base/Controller.zig").Controller;

pub const Route = struct {
    name: []const u8,
    title: []const u8,
    path: []const u8,
    controller: Controller,
};
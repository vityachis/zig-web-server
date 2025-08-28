const std = @import("std");
const http = std.http;

pub const Controller = struct {
    create: *const fn(req: *http.Server.Request) anyerror!void,
    read: *const fn(req: *http.Server.Request) anyerror!void,
    update: *const fn(req: *http.Server.Request) anyerror!void,
    delete: *const fn(req: *http.Server.Request) anyerror!void,
    list: *const fn(req: *http.Server.Request) anyerror!void,
};
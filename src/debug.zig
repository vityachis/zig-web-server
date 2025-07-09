const std = @import("std");

pub fn pMessage(message: []const u8) void {
    std.debug.print("[MESSAGE] {s}\n", .{message});
}

pub fn pDebug(context: []const u8, variable: anytype) void {
    std.debug.print("[DEBUG] {s}: {any}\n", .{context, variable});
}

pub fn pInfo(context: []const u8, message: []const u8) void {
    std.debug.print("[INFO] {s}: {s}\n", .{context, message});
}

pub fn pError(context: []const u8, err: anyerror) void {
    std.debug.print("[ERROR] {s}: {s}\n", .{context, @errorName(err)});
}
const std = @import("std");
const http = std.http;
const Route = @import("../base/Route.zig").Route;
const DefaultController = @import("../controllers/Default.zig").Default;
const Controller = @import("../base/Controller.zig").Controller;

pub fn routes() [1]Route {
    return [_]Route{
        Route{
            .name = "index",
            .title = "Hello, Zig!",
            .path = "/",
            .controller = Controller{
                .create = DefaultController.create,
                .read = DefaultController.read,
                .update = DefaultController.update,
                .delete = DefaultController.delete,
                .list = DefaultController.list,
            },
        },
    };
}

const std = @import("std");

const b64encoder = std.base64.standard.Encoder;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const alloc = arena.allocator();

    var args = try std.process.argsWithAllocator(alloc);
    _ = args.skip();

    const template_path = args.next() orelse {
        return GenError.MissingTemplate;
    };

    const src_path = args.next() orelse {
        return GenError.MissingSrc;
    };
    const dst_path = args.next() orelse {
        return GenError.MissingDst;
    };

    const cwd = std.fs.cwd();

    const src = try cwd.readFileAlloc(alloc, src_path, 1024 * 1024);
    const template = try cwd.readFileAlloc(alloc, template_path, 1024 * 1024);

    const dst = try alloc.alloc(u8, b64encoder.calcSize(src.len));
    const html = try std.mem.replaceOwned(u8, alloc, template, "{}", b64encoder.encode(dst, src));

    const dst_file = try cwd.createFile(dst_path, .{});
    defer dst_file.close();
    try dst_file.writeAll(html);
}

const GenError = error{
    MissingSrc,
    MissingDst,
    MissingTemplate,
};

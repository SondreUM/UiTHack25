const std = @import("std");
const obfuscate = @import("obfuscate.zig");

const USAGE = "USAGE: ./encryptor <file> <key>\n";

pub fn main() !void {
    var buffer: [0x1000 * 32]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const alloc = fba.allocator();

    var args = std.process.args();
    _ = args.skip();
    const in_path = args.next() orelse {
        std.debug.print("{s}", .{USAGE});
        return;
    };

    const out_path = args.next() orelse {
        std.debug.print("{s}", .{USAGE});
        return;
    };

    const plaintext = try std.fs.cwd().readFileAlloc(alloc, in_path, 1024 * 8);
    const ciphertext = try alloc.alloc(u8, plaintext.len);

    obfuscate.xor(ciphertext, plaintext);
    const out_file = try std.fs.cwd().createFile(out_path, .{});
    defer out_file.close();
    try out_file.writeAll(ciphertext);
}

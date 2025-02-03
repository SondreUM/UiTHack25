const std = @import("std");
const builtin = @import("builtin");
const obfuscate = @import("obfuscate.zig");

const mem = std.mem;
const page_allocator = std.heap.page_allocator;

fn shellcodeEncrypted() []const u8 {
    const code = @embedFile("shellcode_encrypted");
    if (code.len > 0x1000) {
        @compileError("shellcode too large");
    }
    return code;
}
const SHELLCODE_ENCRYPTED = shellcodeEncrypted();

pub fn main() !void {
    var buf: [0x1000]u8 = undefined;
    var bufalloc = std.heap.FixedBufferAllocator.init(&buf);

    var args = try std.process.argsWithAllocator(bufalloc.allocator());
    _ = args.skip();

    const flag_guess = args.next() orelse {
        std.debug.print("USAGE: ./verifier <flag>\n", .{});
        return;
    };

    var shellcode: [SHELLCODE_ENCRYPTED.len]u8 = undefined;
    obfuscate.xor(&shellcode, SHELLCODE_ENCRYPTED);

    try execVerifier(&shellcode, flag_guess);
}

const ExecError = error{
    AllocFailure,
};

fn execVerifier(shellcode: []const u8, flag_guess: []const u8) !void {
    const codebuf = try page_allocator.alignedAlloc(
        u8,
        mem.page_size,
        1 * mem.page_size,
    );

    defer page_allocator.free(codebuf);

    @memcpy(codebuf[0..shellcode.len], shellcode);

    try std.posix.mprotect(codebuf, std.posix.PROT.READ | std.posix.PROT.EXEC);

    const fptr: *const fn ([*]const u8, usize) callconv(.C) void = @ptrCast(codebuf);
    std.debug.print("Validator loaded as {*}\n", .{fptr});

    fptr(flag_guess.ptr, flag_guess.len);
}

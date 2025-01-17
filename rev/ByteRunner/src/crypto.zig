const std = @import("std");
const chacha = std.crypto.stream.chacha.ChaCha8IETF;
const mem = std.mem;

const KEY = init_key("supersecretpassword");
const NONCE = mem.zeroes([12]u8);

pub fn encrypt(out: []u8, in: []const u8) void {
    chacha.xor(out, in, 0, KEY, NONCE);
}

pub noinline fn decrypt(out: []u8, in: []const u8) void {
    @call(.never_inline, chacha.xor, .{ out, in, 0, KEY, NONCE });
}

fn init_key(password: []const u8) [32]u8 {
    if (password.len > 32) {
        @compileError("password too long");
    }
    var buf = mem.zeroes([32]u8);
    @memcpy(buf[0..password.len], password);
    return buf;
}

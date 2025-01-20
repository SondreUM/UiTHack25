pub fn xorComptime(comptime bytes: []const u8) [bytes.len]u8 {
    var out: [bytes.len]u8 = undefined;

    xor(&out, bytes[0..bytes.len]);

    return out;
}

pub fn xor(dst: []u8, src: []const u8) void {
    const len = @min(dst.len, src.len);

    for (0..len) |i| {
        dst[i] = src[i] ^ @as(u8, @truncate(i + 0x45));
    }
}

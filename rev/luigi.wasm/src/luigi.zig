const std = @import("std");
const chacha = std.crypto.stream.chacha.ChaCha8IETF;

extern fn print(i32) void;

const LUIGI_JPG = @embedFile("luigi.jpg");
const FLAG = &encrypt_flag("UitHack25{eatTheCorporateOverlords}");

export fn get_img_ptr() [*]const u8 {
    return LUIGI_JPG;
}

export fn get_img_len() usize {
    return LUIGI_JPG.len;
}

export fn get_flag_ptr() [*]const u8 {
    return FLAG;
}

export fn get_flag_len() usize {
    return FLAG.len;
}

const KEY = create_key("supersecretpassword");

export fn decrypt_flag(flag: [*]u8, flag_len: usize) void {
    const flag_slice = flag[0..flag_len];
    chacha.xor(flag_slice, flag_slice, 0, KEY, [_]u8{0} ** chacha.nonce_length);
}

fn encrypt_flag(comptime flag: []const u8) [flag.len]u8 {
    var out: [flag.len]u8 = undefined;
    @memcpy(&out, flag);
    decrypt_flag(&out, flag.len);
    return out;
}

fn create_key(key: []const u8) [chacha.key_length]u8 {
    var out = [_]u8{0} ** chacha.key_length;
    @memcpy(out[0..key.len], key);
    return out;
}

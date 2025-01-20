const std = @import("std");
const obfuscate = @import("obfuscate.zig");

const FLAG = &obfuscate.xorComptime("UiTHack25{IWasExecutableImTwiceAsExecutableNow}");
const SUCCESS = "Success, the flag is: ";

const FAILURE = "Validation failed. Try again, or don't.\n";

pub export fn _start(guess: [*]const u8, len: usize) callconv(.C) void {
    var flag: [FLAG.len]u8 = undefined;
    obfuscate.xor(&flag, FLAG);

    if (len != flag.len or !std.mem.eql(u8, guess[0..len], &flag)) {
        std.crypto.utils.secureZero(u8, &flag);
        _ = std.os.linux.write(0, FAILURE, FAILURE.len);
        return;
    }
    _ = std.os.linux.write(0, SUCCESS, SUCCESS.len);
    _ = std.os.linux.write(0, &flag, flag.len);
    _ = std.os.linux.write(0, "\n", 1);
}

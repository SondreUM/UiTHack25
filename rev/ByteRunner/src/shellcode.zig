const std = @import("std");

const FLAG = "UiTHack25{IWasExecutableImTwiceAsExecutableNow}";
const SUCCESS = std.fmt.comptimePrint("Success, the flag is: {s}\n", .{FLAG});

const FAILURE = "Validation failed. Try again, or don't.\n";

pub export fn _start(guess: [*]const u8, len: usize) callconv(.C) void {
    if (len != FLAG.len or !std.mem.eql(u8, guess[0..len], FLAG)) {
        _ = std.os.linux.write(0, FAILURE, FAILURE.len);
        return;
    }
    _ = std.os.linux.write(0, SUCCESS, SUCCESS.len);
}

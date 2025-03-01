const std = @import("std");

pub fn main() !void {
    const out = std.io.getStdOut().writer();
    const in = std.io.getStdIn().reader();

    try out.print("Input password: ", .{});

    var password: [32]u8 = undefined;
    const n = try in.read(&password);

    if (std.mem.eql(u8, "supersecretpassword", password[0 .. n - 1])) {
        @"VWlUSGFjazI1e0NZQjNSX000VFIxWF9CNFMzNjRfRDNDUllQVEkwTn0="();
    } else {
        try out.print("Wrong password bro\n", .{});
    }
}

export fn @"VWlUSGFjazI1e0NZQjNSX000VFIxWF9CNFMzNjRfRDNDUllQVEkwTn0="() void {
    std.debug.print("VEhJU19JU19OT1RfVEhFX0ZMQUdfSEVIRQ==\n", .{});
}

export fn print_the_flag() void {
    std.debug.print("UkVBTExZPw==\n", .{});
}

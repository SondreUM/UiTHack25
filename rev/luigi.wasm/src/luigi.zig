const std = @import("std");

extern fn print(i32) void;

const LUIGI_JPG = @embedFile("luigi.jpg");

export fn get_img_ptr() [*]const u8 {
    return LUIGI_JPG;
}

export fn get_img_len() i32 {
    return LUIGI_JPG.len;
}

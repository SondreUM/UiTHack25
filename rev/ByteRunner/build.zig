const std = @import("std");
const builtin = @import("builtin");


const ZIG_VERSION = builtin.zig_version;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const encryptor = b.addExecutable(.{
        .name = "encryptor",
        .target = b.host,
        .optimize = .Debug,
        .root_source_file = b.path("src/encryptor.zig"),
        .strip = true,
        .single_threaded = true,
    });

    const payload = b.addExecutable(.{
        .name = "shellcode",
        .target = b.resolveTargetQuery(.{
            .os_tag = .freestanding,
            .cpu_arch = target.result.cpu.arch,
            .abi = target.result.abi,
        }),
        .optimize = .ReleaseSmall,
        .root_source_file = b.path("src/shellcode.zig"),
        .single_threaded = true,
        .pic = true,
        .strip = true,
        .error_tracing = false,
        .unwind_tables = false,
    });
    payload.setLinkerScript(b.path("src/shellcode.ld"));
    payload.build_id = .none;

    const shellcode = b.addObjCopy(
        payload.getEmittedBin(),
        .{ .format = .bin },
    );

    const encrypt_step = b.addRunArtifact(encryptor);
    encrypt_step.addFileArg(shellcode.getOutput());
    const shellcode_encrypted = encrypt_step.addOutputFileArg("shellcode.encrypted");

    const runner = b.addExecutable(.{
        .name = "runner",
        .root_source_file = b.path("src/runner.zig"),
        .target = target,
        .single_threaded = true,
        .optimize = .ReleaseSmall,
        .strip = true,
        .error_tracing = false,
        .unwind_tables = false,
    });
    runner.build_id = .none;

    runner.root_module.addAnonymousImport("shellcode_encrypted", .{
        .root_source_file = shellcode_encrypted,
    });

    b.installArtifact(runner);

    const run_loader = b.addRunArtifact(runner);
    const load = b.step("load", "Run byte runner");
    load.dependOn(&run_loader.step);
    if (b.args) |args| {
        run_loader.addArgs(args);
    }
}

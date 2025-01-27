const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const lib = b.addSharedLibrary(.{
        .name = "luigi",
        .root_source_file = b.path("src/luigi.zig"),
        .target = b.resolveTargetQuery(.{
            .cpu_arch = .wasm32,
            .os_tag = .wasi,
        }),
        .optimize = .ReleaseSmall,
        .link_libc = false,
    });

    b.installArtifact(lib);
}

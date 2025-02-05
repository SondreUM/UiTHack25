const std = @import("std");

pub fn build(b: *std.Build) void {
    const gen_html = b.addExecutable(.{
        .name = "gen_html",
        .root_source_file = b.path("src/gen_html.zig"),
        .target = b.host,
    });

    const luigi = b.addExecutable(.{
        .name = "luigi",
        .root_source_file = b.path("src/luigi.zig"),
        .target = b.resolveTargetQuery(.{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
        }),
        .optimize = .ReleaseSmall,
    });
    luigi.entry = .disabled;
    luigi.rdynamic = true;

    const gen_html_step = b.addRunArtifact(gen_html);
    gen_html_step.addFileArg(b.path("src/luigi.html"));
    gen_html_step.addFileArg(luigi.getEmittedBin());
    const html = gen_html_step.addOutputFileArg("luigi.html");
    b.getInstallStep().dependOn(&b.addInstallFileWithDir(html, .prefix, "luigi.html").step);

    b.installArtifact(luigi);
}

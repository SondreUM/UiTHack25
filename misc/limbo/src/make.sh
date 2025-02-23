# Compile direct
clang -o program_direct program.c

# Compile to LLVM IR
clang -S -emit-llvm -o program.ll program.c

# Compile LLVM IR to executable
clang -o program_indirect program.ll

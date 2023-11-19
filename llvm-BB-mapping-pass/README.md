### Build
```bash
mkdir build && cd build
cmake -DLT_LLVM_INSTALL_DIR=/usr/lib/llvm-14/ ..
make
```


### Run
```bash
opt-14  -load-pass-plugin=/build/lib/libInjectAsmComments.so -passes="inject-asm-comments" test.ll -S -o test_comments.ll
```
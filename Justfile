flags := "-march=native -O3 -flto -fuse-ld=lld -fomit-frame-pointer -mllvm=-enable-dfa-jump-thread -fno-plt -ffunction-sections -fdata-sections -Wl,--icf=all -Wl,--gc-sections -Wl,-O2 -Wl,--as-needed -Wl,-z,relro -Wl,-z,now -Wl,--exclude-libs,ALL -Wl,--strip-all"

export CC := "clang"
export CXX := "clang++"
export CFLAGS := flags
export CXXFLAGS := flags
export RUSTFLAGS := "--cfg tokio_unstable -Ctarget-cpu=native -Clinker-plugin-lto -Clinker=clang -Clink-arg=-fuse-ld=lld -Cllvm-args=-enable-dfa-jump-thread -Clink-args=-Wl,--icf=all,-z,stack-size=0x80000000,--gc-sections,-O2,--as-needed,-z,relro,-z,now,--exclude-libs,ALL,--strip-all"

default: build

build:
    cargo +nightly -Z build-std build --profile opt --bin hx

install:
    cp -f target/opt/hx ~/.local/bin/hx
    cp -fr runtime/queries/* ~/.config/helix/runtime/queries/
    cp -fr runtime/themes/* ~/.config/helix/runtime/themes/
    hx --grammar fetch
    hx --grammar build

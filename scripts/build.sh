#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p build
cd build
curl -fSL "https://www.sqlite.org/2026/sqlite-autoconf-3540100.tar.gz" -o sqlite.tar.gz
tar xf sqlite.tar.gz
cd sqlite-autoconf-3540100
CC=clang CFLAGS='-O2 -pipe -fPIC' \
  ./configure \
    --enable-static-shell \
    --with-readline-cflags='-I/data/data/com.termux/files/usr/include' \
    --with-readline-ldflags='-lncurses -lreadline' \
    CFLAGS='-DSQLITE_ENABLE_JSON1 -DSQLITE_ENABLE_FTS5 -DSQLITE_ENABLE_RTREE -DSQLITE_ENABLE_GEOPOLY -DSQLITE_ENABLE_DBSTAT_VTAB -DSQLITE_ENABLE_STAT4 -DSQLITE_ENABLE_UNLOCK_NOTIFY -DSQLITE_HAVE_ZLIB=1 -DSQLITE_THREADSAFE=1'
make -j"$(nproc)"
cp sqlite3 ../bin/sqlite3
cp libsqlite3.so ../dist/libsqlite3.so
cp libsqlite3.a ../dist/libsqlite3.a
echo "✅ Build completo: bin/sqlite3"

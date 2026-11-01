# sqlite3-aarch64

SQLite 3.54.1 compilado nativamente para **Android/Termux aarch64**, com features avançadas habilitadas.

## Features

- JSON1, FTS5, RTREE, GEOPOLY
- MATH, STAT4, UNLOCK_NOTIFY
- DBPAGE/DBSTAT, PERCENTILE
- readline + ncurses
- zlib, thread-safe
- -O2 -fPIC

## Uso

```bash
cp bin/sqlite3 ~/bin/sqlite3
export PATH="$HOME/bin:$PATH"
sqlite3 --version
```

## Build

```bash
bash scripts/build.sh
```

## Verify

```bash
bash scripts/verify.sh bin/sqlite3
```

## Changelog

- 2026-11-01: build inicial aarch64, features extras habilitadas

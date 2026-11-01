# sqlite3-aarch64

SQLite 3.54.1 compilado nativamente para **Android/Termux aarch64**, com features avançadas habilitadas.

## Build Info

- **Versão:** 3.54.1 (2026-10-16)
- **Arquitetura:** aarch64 (ARM64)
- **Compilador:** clang 21
- **Otimização:** -O2 -pipe -fPIC
- **Thread-safe:** sim (MUTEX_PTHREADS=1)

## Features Testadas

Suite oficial de testes: `tests/features.sh`

**Resultado:** 22/22 PASS

| Feature | Status |
|---------|--------|
| JSON1 | PASS |
| FTS5 | PASS |
| RTREE | PASS |
| GEOPOLY | PASS |
| MATH | PASS |
| STAT4 | PASS |
| UNLOCK_NOTIFY | PASS |
| DBPAGE/DBSTAT | PASS |
| PERCENTILE | PASS |
| ZLIB | PASS |
| THREAD-SAFE | PASS |
| READLINE | PASS |

## Features Habilitadas

- **JSON1** — funções JSON nativas
- **FTS5** — busca textual full-text
- **RTREE** — índices espaciais
- **GEOPOLY** — geometria espacial
- **MATH** — funções matemáticas avançadas
- **STAT4** — estatísticas para query planner
- **UNLOCK_NOTIFY** — notificação de unlock WAL
- **DBPAGE/DBSTAT** — inspeção de páginas
- **PERCENTILE** — função de percentil

## Uso

```bash
cp bin/sqlite3 $PREFIX/bin/sqlite3
sqlite3 --version
```

## Build

```bash
bash scripts/build.sh
```

## Verify

```bash
bash scripts/verify.sh sqlite3
bash tests/features.sh sqlite3
```

## Changelog

- **2026-11-01:** Build inicial aarch64 com 12 features extras. Testes 22/22 PASS.

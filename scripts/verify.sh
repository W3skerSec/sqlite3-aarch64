#!/usr/bin/env bash
set -euo pipefail
BIN="$1"
if [ -z "$BIN" ]; then
  echo "Uso: $0 <caminho/sqlite3>"
  exit 1
fi
echo "=== Verificando $BIN ==="
file "$BIN"
"$BIN" --version
echo "=== Features ==="
"$BIN" ':memory:' "SELECT sqlite_version();" .quit
echo "=== JSON1 ==="
"$BIN" ':memory:' "SELECT json('{\"a\":1}');" .quit
echo "✅ Verificação completa"

#!/usr/bin/env bash
set -euo pipefail
CMD="${1:-sqlite3}"
if [ ! -f "$CMD" ]; then
  CMD="$(which "$CMD" 2>/dev/null || true)"
fi
if [ -z "$CMD" ] || [ ! -x "$CMD" ]; then
  echo "❌ sqlite3 não encontrado"
  exit 1
fi
BIN="$CMD"
echo "=== Verificando $BIN ==="
file "$BIN"
"$BIN" --version
echo "=== Features ==="
"$BIN" ':memory:' "SELECT sqlite_version();" .quit
echo "=== JSON1 ==="
"$BIN" ':memory:' "SELECT json('{\"a\":1}');" .quit
echo "✅ Verificação completa"

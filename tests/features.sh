#!/usr/bin/env bash
set -euo pipefail
BIN="${1:-~/bin/sqlite3}"
DB="/data/data/com.termux/files/home/tmp/sqlite3_features_test.db"
PASS=0; FAIL=0

run_test() {
  local name="$1"; shift
  echo -n "TEST: $name ... "
  if "$BIN" "$DB" "$@" >/dev/null 2>&1; then
    echo "PASS"
    PASS=$((PASS+1))
  else
    echo "FAIL"
    FAIL=$((FAIL+1))
  fi
}

rm -f "$DB"
echo "=== SQLite Features Test Suite ==="
echo "Binary: $BIN"
echo

"$BIN" --version
echo

echo "--- JSON1 ---"
run_test "json_extract" "SELECT json_extract('{\"a\":1}', '$.a');"
run_test "json_array" "SELECT json_array(1,2,3);"
run_test "json_object" "SELECT json_object('a',1,'b',2);"
run_test "json_each" "SELECT * FROM json_each('[1,2,3]');"

echo "--- FTS5 ---"
run_test "fts5_create" "CREATE VIRTUAL TABLE t_fts USING fts5(content);"
run_test "fts5_insert" "INSERT INTO t_fts(rowid, content) VALUES (1, 'hello world');"
run_test "fts5_query" "SELECT * FROM t_fts WHERE t_fts MATCH 'hello';"
run_test "fts5_bm25" "SELECT bm25(t_fts) FROM t_fts WHERE t_fts MATCH 'hello';"

echo "--- RTREE ---"
run_test "rtree_create" "CREATE VIRTUAL TABLE t_rtree USING rtree(id, minX, maxX, minY, maxY);"
run_test "rtree_insert" "INSERT INTO t_rtree VALUES (1, 0, 100, 0, 100);"
run_test "rtree_query" "SELECT * FROM t_rtree WHERE maxX >= 50;"

echo "--- GEOPOLY ---"
run_test "geopoly_create" "CREATE VIRTUAL TABLE t_geo USING geopoly;"
run_test "geopoly_insert" "INSERT INTO t_geo VALUES ('MULTIPOINT(0 0, 1 1)');"
run_test "geopoly_query" "SELECT * FROM t_geo WHERE geopoly_overlap(_shape, 'MULTIPOINT(0 0, 2 2)');"

echo "--- MATH ---"
run_test "math_basic" "SELECT acos(0.5), asin(0.5), atan(1), atan2(1,1), ceil(1.2), cos(0), degrees(1), exp(1), floor(1.2), ln(2), log(10,100), log10(100), log2(8), mod(10,3), pi(), pow(2,3), radians(180), sin(1), sqrt(4), tan(1), trunc(1.7);"

echo "--- STAT4 ---"
run_test "stat4" "PRAGMA optimize; ANALYZE; SELECT * FROM sqlite_stat4 LIMIT 1;"

echo "--- UNLOCK_NOTIFY ---"
run_test "unlock_notify" "PRAGMA unlock_notify;"

echo "--- DBPAGE/DBSTAT ==="
run_test "dbstat" "SELECT * FROM dbstat('main') LIMIT 1;"

echo "--- PERCENTILE ==="
run_test "percentile" "SELECT percentile(x, 50) FROM (SELECT 1 AS x UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5);"

echo "--- ZLIB ==="
run_test "zlib_available" "SELECT sqlite_compileoption_used('SQLITE_ENABLE_ZLIB');"

echo "--- THREAD-SAFE ==="
run_test "threadsafe" "PRAGMA compile_options;"

echo "--- READLINE ==="
run_test "readline_help" ".help"

rm -f "$DB"

echo
echo "=== RESULTADO ==="
echo "Pass: $PASS"
echo "Fail: $FAIL"
if [ "$FAIL" -eq 0 ]; then
  echo "✅ TODAS AS FEATURES OK"
else
  echo "❌ Algumas features falharam"
  exit 1
fi

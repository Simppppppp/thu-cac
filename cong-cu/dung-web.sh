#!/usr/bin/env bash
# Dựng index.html (bản web độc lập) từ page.html (bản dùng chung với claude.ai).
# page.html bắt đầu bằng <title>, <meta>, <link>, <style>…</style> rồi tới phần thân trang.
# Lệnh này đặt phần đầu vào <head>, phần còn lại vào <body>.
set -euo pipefail
cd "$(dirname "$0")/.."

SRC=page.html
OUT=index.html
[ -f "$SRC" ] || { echo "Không thấy $SRC" >&2; exit 1; }

# Dòng kết thúc khối <style> đầu tiên
END=$(grep -n -m1 '^</style>' "$SRC" | cut -d: -f1)
[ -n "$END" ] || { echo "Không tìm thấy </style> trong $SRC" >&2; exit 1; }

ICON="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 64 64'%3E%3Crect width='64' height='64' rx='12' fill='%23b8323c'/%3E%3Ctext x='32' y='46' font-size='38' text-anchor='middle' fill='white' font-family='serif'%3E%E6%9B%B8%3C/text%3E%3C/svg%3E"

{
  printf '%s\n' '<!doctype html>' '<html lang="vi">' '<head>' \
    '<meta charset="utf-8">' \
    '<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">' \
    '<meta name="description" content="Thư Các: đọc truyện Trung convert, sửa name, chỉnh màu chữ, ngay trên trình duyệt.">' \
    '<meta name="theme-color" content="#ebe5d5">' \
    "<link rel=\"icon\" href=\"$ICON\">" \
    '<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}img{max-width:100%}</style>'
  head -n "$END" "$SRC" | grep -v 'name="claude:viewport-fit-sides"'
  printf '%s\n' '</head>' '<body>'
  tail -n +"$((END + 1))" "$SRC"
  printf '%s\n' '</body>' '</html>'
} > "$OUT"

echo "Đã dựng $OUT ($(wc -c < "$OUT") byte) từ $SRC"

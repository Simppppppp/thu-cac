#!/usr/bin/env bash
# Đồng bộ truyện tiếng Việt có sẵn vào trang: chép các chương từ thư mục truyện
# sang truyen/van-chung-lanh-chu/ rồi dựng lại truyen/danh-sach.json.
#   bash cong-cu/dong-bo-truyen.sh
# Xong thì chạy cap-nhat-web.sh để đưa lên GitHub Pages.
set -euo pipefail

# ---- chỉnh ở đây ----
NGUON="C:/Users/OmiBook HP/Truyen/Van-Chung-Lanh-Chu/chuong"   # nơi có ch001.md, ch002.md …
ID="van-chung-lanh-chu"                                        # tên thư mục con trong truyen/
TEN="Toàn Dân Lãnh Chúa: Vạn Chủng Lãnh Chủ"                   # tên truyện hiện trên trang
# ---------------------

cd "$(dirname "$0")/.."
DICH="truyen/$ID"
[ -d "$NGUON" ] || { echo "Không thấy thư mục nguồn: $NGUON" >&2; exit 1; }

# Chỉ lấy ch + đúng 3 chữ số + .md (bỏ 00-*, 01-*, thu-mu, da-duyet.txt…)
shopt -s nullglob
CO=("$NGUON"/ch[0-9][0-9][0-9].md)
[ "${#CO[@]}" -gt 0 ] || { echo "Nguồn không có file chNNN.md nào, dừng để khỏi xóa nhầm." >&2; exit 1; }

mkdir -p "$DICH"

# Xóa chương thừa không còn ở nguồn
XOA=0
for f in "$DICH"/ch[0-9][0-9][0-9].md; do
  if [ ! -f "$NGUON/$(basename "$f")" ]; then rm -f "$f"; XOA=$((XOA + 1)); fi
done

# Chép chương (bỏ ký tự CR để file luôn xuống dòng kiểu LF)
for f in "${CO[@]}"; do
  tr -d '\r' < "$f" > "$DICH/$(basename "$f")"
done

# Thoát dấu \ và " để nhét vào chuỗi JSON
BS='\'
jesc() {
  local s="$1"
  s="${s//$BS/$BS$BS}"
  s="${s//\"/$BS\"}"
  printf '%s' "$s"
}

{
  printf '{"truyen":[\n  {"id":"%s","ten":"%s","chuong":[' "$(jesc "$ID")" "$(jesc "$TEN")"
  SEP=$'\n'
  for f in "$DICH"/ch[0-9][0-9][0-9].md; do
    t=$(head -n1 "$f" | tr -d '\r')
    t="${t#$'\xEF\xBB\xBF'}"                         # bỏ BOM nếu có
    t="${t#\# }"; t="${t#\#}"                         # bỏ "# " đầu dòng
    t="${t#"${t%%[![:space:]]*}"}"                    # bỏ khoảng trắng đầu
    t="${t%"${t##*[![:space:]]}"}"                    # bỏ khoảng trắng cuối
    [ -n "$t" ] || t="$(basename "$f" .md)"
    printf '%s    {"file":"%s/%s","ten":"%s"}' "$SEP" "$(jesc "$ID")" "$(basename "$f")" "$(jesc "$t")"
    SEP=$',\n'
  done
  printf '\n  ]}\n]}\n'
} > truyen/danh-sach.json.tmp
mv truyen/danh-sach.json.tmp truyen/danh-sach.json

echo "Đã đồng bộ ${#CO[@]} chương vào $DICH (xóa $XOA chương thừa) và dựng lại truyen/danh-sach.json"

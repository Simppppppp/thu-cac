#!/usr/bin/env bash
# Cập nhật trang web Thư Các trên GitHub Pages:
#   bash cong-cu/cap-nhat-web.sh "ghi chú thay đổi"
# Dựng lại index.html từ page.html, commit rồi đẩy lên GitHub.
# GitHub Pages tự cập nhật sau khoảng 1–2 phút.
# (Bản trên claude.ai thì Claude publish lại page.html bằng công cụ Artifact.)
set -euo pipefail
cd "$(dirname "$0")/.."

MSG="${1:-Cập nhật trang}"
bash cong-cu/dung-web.sh
git add -A
if git diff --cached --quiet; then
  echo "Không có thay đổi để đẩy lên."
  exit 0
fi
git commit -q -m "$MSG"
git push -q
echo "Đã đẩy lên GitHub. Trang: https://simppppppp.github.io/thu-cac/"

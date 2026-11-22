# Thư Các

Trang đọc truyện Trung convert chạy ngay trên trình duyệt: thêm truyện từ file .txt hoặc dán chữ, đọc bản convert (Name → Vietphrase → Hán Việt), bấm vào từ để sửa name, chỉnh màu nền, cỡ chữ, font.

Mở trang: https://simppppppp.github.io/thu-cac/

- Truyện, name và chỗ đọc dở được lưu trong trình duyệt của từng máy. Dùng nút **Sao lưu** / **Khôi phục** để chuyển sang máy khác.
- Từ điển cài sẵn (`vietphrase.txt`, `hanviet.txt`) lấy từ dữ liệu cộng đồng công khai tại [ryanphung/chinese-hanviet-cognates](https://github.com/ryanphung/chinese-hanviet-cognates). Có thể tải từ điển riêng lên trong mục **Từ điển**.

## Cấu trúc

- `page.html`: mã trang gốc (dùng chung với bản trên claude.ai).
- `index.html`: bản web, dựng từ `page.html` bằng `bash cong-cu/dung-web.sh`.
- `cong-cu/cap-nhat-web.sh "ghi chú"`: dựng lại và đẩy lên GitHub.

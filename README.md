# Thư Các

Trang đọc truyện Trung convert chạy ngay trên trình duyệt: thêm truyện từ file .txt hoặc dán chữ, đọc bản convert (Name → Vietphrase → Hán Việt), bấm vào từ để sửa name, chỉnh màu nền, cỡ chữ, font.

Mở trang: https://simppppppp.github.io/thu-cac/

- Truyện, name và chỗ đọc dở được lưu trong trình duyệt của từng máy. Dùng nút **Sao lưu** / **Khôi phục** để chuyển sang máy khác.
- Từ điển cài sẵn (`vietphrase.txt`, `hanviet.txt`) lấy từ dữ liệu cộng đồng công khai tại [ryanphung/chinese-hanviet-cognates](https://github.com/ryanphung/chinese-hanviet-cognates). Có thể tải từ điển riêng lên trong mục **Từ điển**.

## Cấu trúc

- `page.html`: mã trang gốc (dùng chung với bản trên claude.ai).
- `index.html`: bản web, dựng từ `page.html` bằng `bash cong-cu/dung-web.sh`.
- `cong-cu/cap-nhat-web.sh "ghi chú"`: dựng lại và đẩy lên GitHub.
- `cong-cu/dong-bo-truyen.sh`: đồng bộ truyện có sẵn từ thư mục truyện vào `truyen/`.
- `truyen/`: dữ liệu truyện có sẵn (`danh-sach.json` + các file chương `.md`).

## Truyện có sẵn (truyện tiếng Việt đọc thẳng, không qua bộ dịch)

Bản web có thêm khu **Truyện có sẵn** ở tủ truyện: đọc truyện tiếng Việt nằm trong thư mục `truyen/` (danh sách ở `truyen/danh-sach.json`, mỗi chương một file `.md`). Truyện này không lưu vào trình duyệt, lần nào mở cũng lấy bản mới nhất; chương đang đọc và vị trí cuộn thì nhớ theo từng máy. Bản trên claude.ai không có khu này.

Thêm hoặc cập nhật chương:

1. `bash cong-cu/dong-bo-truyen.sh` — chép các file `chNNN.md` từ thư mục truyện (đường dẫn ở đầu script) vào `truyen/`, xóa chương thừa, dựng lại `truyen/danh-sach.json`.
2. `bash cong-cu/cap-nhat-web.sh "ghi chú"` — dựng lại `index.html`, commit và đẩy lên GitHub Pages.

# Báo cáo BTL Điện tử ứng dụng: Template LaTeX

Template LaTeX chung cho cả nhóm. Mỗi thành viên viết chương của mình trên template này, nhóm trưởng merge lại thành báo cáo hoàn chỉnh.

- **Quy tắc viết (cho người và AI):** [report_guideline.md](report_guideline.md). **Đọc trước khi viết.**
- **Mẫu cú pháp mọi thành phần:** [template/chapter_template.tex](template/chapter_template.tex)

## Biên dịch

### Cài đặt lần đầu (Windows + VS Code)

1. Cài **MiKTeX**: `winget install MiKTeX.MiKTeX`. Khi cài, chọn *Install missing packages on-the-fly = Yes*.
2. Mở **MiKTeX Console** → **Check for updates** → **Update now**. Bắt buộc làm, nếu không mọi lệnh sẽ báo lỗi *"So far, you have not checked for MiKTeX updates"*.
3. Cài extension **LaTeX Workshop** (`james-yu.latex-workshop`) trong VS Code.
4. Khởi động lại VS Code.

### Build

**VS Code:** repo đã có sẵn [.vscode/settings.json](.vscode/settings.json), build theo chuỗi `pdflatex → bibtex → pdflatex ×2` (không dùng latexmk). Mở `main.tex` hoặc bất kỳ file chương nào, nhấn `Ctrl+Alt+B` để build, `Ctrl+Alt+V` để xem PDF. Mỗi lần lưu file sẽ tự build lại.

> Nếu mở cả thư mục cha (không phải `Report/`) làm workspace trong VS Code, hãy copy `.vscode/settings.json` sang thư mục `.vscode/` của workspace đó.

**Dòng lệnh:**

```bash
pdflatex main && bibtex main && pdflatex main && pdflatex main
```

`latexmk main.tex` cũng dùng được, **trừ khi đường dẫn thư mục có dấu tiếng Việt** (latexmk trên Windows lỗi *"Problem making path"*). Tốt nhất clone repo vào thư mục không dấu, VD `D:\BTL\Report`.

**Overleaf:** upload cả thư mục (zip), chọn Compiler = pdfLaTeX, Main document = `main.tex`.

Biên dịch nhanh chỉ chương của mình: bỏ comment dòng `% \includeonly{chapters/chuong3}` trong `main.tex` (sửa đúng tên chương). **Không commit thay đổi này.**

## Phân công file

| Chương | File | Ảnh | TLTK | Người phụ trách |
|---|---|---|---|---|
| 1. Giới thiệu đề tài | `chapters/chuong1.tex` | `image/chuong1/` | `references/chuong1.bib` | _điền tên_ |
| 2. Cơ sở lý thuyết & chọn linh kiện | `chapters/chuong2.tex` | `image/chuong2/` | `references/chuong2.bib` | _điền tên_ |
| 3. Tính toán & mô phỏng | `chapters/chuong3.tex` | `image/chuong3/` | `references/chuong3.bib` | _điền tên_ |
| 4. Mạch đọc dòng & ADC | `chapters/chuong4.tex` | `image/chuong4/` | `references/chuong4.bib` | _điền tên_ |
| 5. Phần cứng | `chapters/chuong5.tex` | `image/chuong5/` | `references/chuong5.bib` | _điền tên_ |
| 6. Kết quả thực nghiệm | `chapters/chuong6.tex` | `image/chuong6/` | `references/chuong6.bib` | _điền tên_ |
| Kết luận, phụ lục, `config/`, `main.tex` | | | | Nhóm trưởng |

## Quy trình Git

Mỗi thành viên làm trên **nhánh riêng**, chỉ sửa file của mình, nên khi merge sẽ không bị conflict.

### Thành viên

```bash
# 1. Clone (lần đầu)
git clone <URL_REPO>
cd <TEN_REPO>

# 2. Tạo nhánh riêng theo chương
git checkout -b chuong3-tenban

# 3. Viết, biên dịch kiểm tra, rồi commit
git add chapters/chuong3.tex image/chuong3/ references/chuong3.bib
git commit -m "chuong3: viet muc mach V-I converter"

# 4. Đẩy nhánh lên
git push -u origin chuong3-tenban
```

Cập nhật template mới nhất từ `main` (khi nhóm trưởng sửa config):

```bash
git fetch origin
git merge origin/main
```

### Nhóm trưởng: merge

```bash
git checkout main
git pull
git fetch origin
git merge origin/chuong3-tenban      # lặp lại cho từng nhánh
latexmk main.tex                     # kiểm tra biên dịch
git push
```

Hoặc tạo Pull Request trên GitHub/GitLab để review trước khi merge.

## Quy ước commit message

`<phạm vi>: <mô tả ngắn không dấu>`, ví dụ: `chuong2: them bang thong so loadcell`, `config: them goi circuitikz`, `image/chuong5: them anh layout`.

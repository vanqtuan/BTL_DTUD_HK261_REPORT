# REPORT GUIDELINE: quy tắc viết báo cáo LaTeX (dành cho người viết và mô hình AI)

> **Cách dùng với AI (ChatGPT, Claude, Gemini, Copilot, ...):**
> 1. Gửi cho AI **toàn bộ file này** cùng với: `config/macros.tex`, `template/chapter_template.tex` và **file chương bạn phụ trách** (VD `chapters/chuong3.tex`).
> 2. Dán **Prompt mẫu** ở [Mục 12](#12-prompt-mẫu-cho-ai) rồi điền nội dung kỹ thuật (số liệu, tên ảnh, kết quả mô phỏng).
> 3. Kiểm tra kết quả theo [Checklist](#11-checklist-trước-khi-commit) trước khi commit.
>
> Các quy tắc có nhãn **[BẮT BUỘC]** không được vi phạm. AI phải tuân thủ tuyệt đối.

---

## 0. Ngữ cảnh dự án (đưa cho AI biết)

- **Môn:** Điện tử ứng dụng, Bộ môn Điện tử, Khoa Điện - Điện tử, ĐH Bách Khoa TP.HCM.
- **Đề tài 9:** Thiết kế mạch đo khối lượng (tiểu ly) dùng Load cell. Tầm đo 0–1 kg, độ phân giải 2 mg, ngõ ra dòng 4–20 mA (thả nổi). Gồm: (a) chọn và mô phỏng Load cell; (b) chọn và mô phỏng OPAMP theo datasheet; (c) mạch bù nhiệt; (d) sai số ±5%; (e) mạch đọc dòng, ngõ ra ADC, chọn ADC, mô phỏng kiểm chứng.
- **Trình biên dịch:** pdfLaTeX, gói `vietnam` (utf8), lớp `extreport`, cỡ chữ 13pt.
- **Ngôn ngữ báo cáo:** tiếng Việt có dấu, văn phong học thuật, ngôi “nhóm” / “chúng em”.

---

## 1. Cấu trúc thư mục

```
Report/
├── main.tex                  # File gốc (CHỈ nhóm trưởng sửa)
├── config/
│   ├── info.tex              # Tên đề tài, GVHD, nhóm, thành viên (CHỈ nhóm trưởng)
│   ├── preamble.tex          # Gói lệnh + định dạng (CHỈ nhóm trưởng)
│   └── macros.tex            # Lệnh tự định nghĩa: \hinh, \haihinh, \nhanxet, ... (CHỈ nhóm trưởng)
├── frontmatter/              # Trang bìa, phân công, lời cảm ơn
├── chapters/
│   ├── chuong1.tex … chuong6.tex
│   ├── ketluan.tex           # Kết luận (không đánh số)
│   └── phuluc.tex            # Phụ lục
├── image/
│   ├── common/               # Logo trường
│   ├── chuong1/ … chuong6/   # Ảnh của từng chương
│   ├── ketluan/  phuluc/
├── references/
│   ├── common.bib            # TLTK dùng chung (key: cm_...)
│   └── chuong1.bib … chuong6.bib   # TLTK từng chương (key: c1_..., c2_...)
├── template/chapter_template.tex   # Mẫu cú pháp mọi thành phần
├── report_guideline.md       # File này
└── README.md                 # Hướng dẫn git và biên dịch
```

| Chương | File | Nội dung | Tiền tố |
|---|---|---|---|
| 1 | `chapters/chuong1.tex` | Giới thiệu đề tài, yêu cầu, sơ đồ khối | `c1` |
| 2 | `chapters/chuong2.tex` | Cơ sở lý thuyết và lựa chọn linh kiện | `c2` |
| 3 | `chapters/chuong3.tex` | Tính toán và mô phỏng mạch xử lý tín hiệu (yêu cầu a–d) | `c3` |
| 4 | `chapters/chuong4.tex` | Mạch đọc dòng và bộ ADC (yêu cầu e) | `c4` |
| 5 | `chapters/chuong5.tex` | Thiết kế và thi công phần cứng | `c5` |
| 6 | `chapters/chuong6.tex` | Kết quả thực nghiệm và đánh giá | `c6` |
| – | `chapters/ketluan.tex` | Kết luận và hướng phát triển | `kl` |
| – | `chapters/phuluc.tex` | Phụ lục | `pl` |

---

## 2. Phạm vi chỉnh sửa [BẮT BUỘC]

1. Mỗi thành viên **chỉ sửa**:
   - file chương của mình trong `chapters/`,
   - thư mục ảnh của mình `image/chuongN/`,
   - file TLTK của mình `references/chuongN.bib`,
   - dòng của mình trong `frontmatter/nhiemvu.tex`.
2. **KHÔNG** sửa `main.tex`, `config/*`, `frontmatter/titlepage.tex`, `frontmatter/loicamon.tex`, file chương của người khác.
3. **KHÔNG** viết trong file chương: `\documentclass`, `\usepackage`, `\begin{document}`, `\end{document}`, `\newcommand`, `\renewcommand`, `\def`, `\input`, `\include`, `\setlength`, `\titleformat`, `\geometry`, `\pagestyle`, `\newpage`/`\clearpage` (trừ khi thật cần).
4. Cần gói lệnh hay macro mới: **báo nhóm trưởng** để thêm vào `config/`. AI không được tự thêm.
5. **KHÔNG** gõ cứng tên GVHD, tên đề tài, tên nhóm. Dùng macro: `\GVHD`, `\TenDeTai`, `\TenNhom`, `\TenMonHoc`, `\SoDeTai`.

---

## 3. Cấu trúc một file chương [BẮT BUỘC]

```latex
% =====================================================================
%  CHƯƠNG N — TÊN CHƯƠNG
% ---------------------------------------------------------------------
%  Người phụ trách : Họ tên - MSSV
%  Tiền tố label   : cN
%  Thư mục ảnh     : image/chuongN/
%  File TLTK       : references/chuongN.bib   (key: cN_...)
%  ...
% =====================================================================
\chapter{Tên chương}
\label{chap:cN}

% ---------------------------------------------------------------------
\section{Tên mục}
\label{sec:cN:ten-muc}

Nội dung...
```

- Giữ nguyên khối comment header, chỉ điền thông tin.
- **Giữ nguyên tên `\chapter{}` và các `\section{}` có sẵn** trong khung. Được thêm `\section`/`\subsection` mới nếu cần, nhưng không xóa hay đổi thứ tự mục có sẵn khi chưa hỏi nhóm trưởng.
- Mỗi `\section` và `\subsection` **phải có** `\label{sec:cN:...}` ngay sau.
- Phân cấp tối đa: `\section` → `\subsection` → `\subsubsection` (hạn chế). Ý nhỏ hơn dùng `\tieumuc{...}`.
- Trước mỗi `\section` đặt 1 dòng comment phân cách `% ------...` cho dễ đọc.
- Tiêu đề mục: viết hoa chữ cái đầu, **không** dấu chấm cuối, **không** in đậm thủ công.

---

## 4. Quy ước đặt label [BẮT BUỘC]

Định dạng: `<loại>:<tiền tố chương>:<tên-không-dấu-gạch-nối>`

| Loại | Mẫu | Ví dụ |
|---|---|---|
| Chương | `chap:cN` | `chap:c3` |
| Mục | `sec:cN:ten` | `sec:c3:vi-converter` |
| Hình | `fig:cN:ten` | `fig:c3:mo-phong-m1` |
| Bảng | `tab:cN:ten` | `tab:c2:thong-so-loadcell` |
| Phương trình | `eq:cN:ten` | `eq:c3:do-loi-ina` |
| Code | `lst:cN:ten` | `lst:c4:doc-adc` |
| Key TLTK | `cN_ten` | `c2_ina333` |

- Tên label: chữ thường, **không dấu**, nối bằng `-`, không khoảng trắng, không `_` (trừ key TLTK).
- Tiền tố chương giúp **không bị trùng label khi merge**. Tuyệt đối không bỏ tiền tố.

---

## 5. Văn phong và trình bày chữ

1. Tiếng Việt có dấu, câu hoàn chỉnh, văn phong khoa học, khách quan. Ngôi xưng: “nhóm”, “chúng em”. Không dùng “tôi”, “bạn”, “mình”.
2. Mỗi đoạn văn cách nhau **một dòng trống**. **Không** dùng `\\` để kết thúc đoạn hay tạo khoảng trắng. Không dùng `\vspace` tùy tiện.
3. Thuật ngữ tiếng Anh lần đầu: viết tiếng Việt kèm tiếng Anh in nghiêng trong ngoặc, VD: *bộ khuếch đại dụng cụ (\textit{Instrumentation Amplifier}, INA)*. Những lần sau dùng từ viết tắt.
4. `\textbf{}` chỉ để nhấn mạnh thuật ngữ quan trọng. Không in đậm cả câu.
5. Không dùng emoji, không dùng markdown (`**`, `#`, `-` đầu dòng) trong file `.tex`.
6. Mỗi hình, bảng, công thức đánh số **phải được nhắc tới trong văn bản** trước hoặc ngay sau khi xuất hiện (VD: “như Hình~\ref{fig:c3:vi-converter}”).
7. Dùng `~` trước `\ref`, `\cite`: `Hình~\ref{...}`, `Bảng~\ref{...}`, `datasheet~\cite{...}`. Phương trình dùng `\eqref{...}` (tự có ngoặc).
8. Ký tự đặc biệt phải escape: `\%`, `\&`, `\_`, `\#`, `\$`.
9. Dấu thập phân: **dấu chấm** (3.3 V), thống nhất toàn báo cáo.
10. Khoảng giá trị trong văn bản: `4--20mA` (gạch nối kép) hoặc `\qtyrange{4}{20}{\milli\ampere}`.

---

## 6. Đại lượng, đơn vị, ký hiệu [BẮT BUỘC]

Dùng gói `siunitx`:

| Viết | Kết quả |
|---|---|
| `\qty{3.3}{\volt}` | 3.3 V |
| `\qty{20}{\milli\ampere}` | 20 mA |
| `\qty{10}{\kilo\ohm}` / `\qty{3.3}{\ohm}` | 10 kΩ / 3.3 Ω |
| `\qty{100}{\nano\farad}` / `\qty{1}{\micro\farad}` | 100 nF / 1 µF |
| `\qty{25}{\celsius}` | 25 °C |
| `\qty{2}{\milli\gram}` / `\qty{1}{\kilo\gram}` | 2 mg / 1 kg |
| `\qty{5}{\percent}` | 5 % |
| `\qty{1}{\milli\volt\per\volt}` | 1 mV/V |
| `\qtyrange{4}{20}{\milli\ampere}` | 4–20 mA |
| `\unit{\milli\ampere}` | mA (đơn vị đứng riêng, VD tiêu đề cột bảng) |

- **Không** viết `5mV`, `10k$\Omega$`, `25$^o C$` thủ công.
- Ký hiệu có chỉ số chữ: chỉ số dạng đứng `R_{\mathrm{shunt}}`, `V_{\mathrm{out}}`. Có sẵn macro: `\Vin`, `\Vout`, `\Vref`, `\Rshunt`.
- Biến số in nghiêng (mặc định trong math): `$R_1$`, `$m$`, `$G$`.

---

## 7. Công thức toán

1. Công thức trong dòng: `$...$`. **Không** dùng `$$...$$`.
2. Công thức đứng riêng cần tham chiếu: môi trường `equation` + `\label{eq:cN:...}`.
3. Chuỗi biến đổi nhiều dòng: `align` (đánh số từng dòng) hoặc `align*` (không đánh số). Căn theo dấu `&=`.
4. Hệ phương trình: `\left\{ \begin{aligned} ... \end{aligned} \right.` đặt trong `equation`.
5. Kết quả quan trọng: `\[ \ketqua{...} \]` (đóng khung).
6. Phân số trong công thức đứng riêng: `\frac`. Không lạm dụng `\dfrac` trong dòng.
7. Sau công thức, giải thích ký hiệu bằng câu “trong đó $X$ là ..., $Y$ là ...”.
8. Không dùng `flalign`, `eqnarray`, `\boxed` trực tiếp (dùng `\ketqua`).

---

## 8. Hình ảnh [BẮT BUỘC]

1. Ảnh đặt trong `image/chuongN/`. Tên file: **chữ thường, không dấu, không khoảng trắng**, nối bằng `_`, VD: `vi_converter_m1.png`. Không dùng `=` trong tên file.
2. Định dạng: `.png` cho ảnh chụp màn hình mô phỏng, `.jpg` cho ảnh chụp thực tế, `.pdf` cho hình vector. Ảnh ≤ 2 MB.
3. **Luôn dùng macro**, không tự viết `\begin{figure}` (trừ subfigure):
   ```latex
   % Một hình (width tùy chọn, mặc định 0.8\textwidth)
   \hinh[0.6\textwidth]{chuong3/vi_converter.png}{Mạch chuyển đổi V-I}{fig:c3:vi-converter}

   % Hai hình cạnh nhau
   \haihinh{chuong3/m0.png}{Mô phỏng khi $m = \qty{0}{\kilo\gram}$}{fig:c3:m0}%
           {chuong3/m1.png}{Mô phỏng khi $m = \qty{1}{\kilo\gram}$}{fig:c3:m1}
   ```
4. Đường dẫn ảnh **tính từ `image/`** và **phải có phần mở rộng** (`.png`/`.jpg`/`.pdf`). Nếu ảnh chưa có, PDF hiện khung đỏ “THIẾU ẢNH” (không lỗi biên dịch), nhưng bản final không được còn khung này.
5. Hình con chung một số: dùng `subfigure` như mẫu trong `template/chapter_template.tex`, ảnh bên trong chèn bằng `\chenanh{\textwidth}{...}`.
6. Chú thích (caption): ngắn gọn, viết hoa chữ đầu, **không** dấu chấm cuối, mô tả đủ nghĩa (VD: “Mô phỏng mạch V-I khi $m = \qty{1}{\kilo\gram}$”, không viết “Hình mô phỏng”).
7. **Tên hình nằm DƯỚI hình** (macro tự xử lý).
8. Sau mỗi hình kết quả mô phỏng/đo đạc **phải có** `\nhanxet{...}`.

---

## 9. Bảng [BẮT BUỘC]

1. Dạng chuẩn: bảng **kẻ khung đầy đủ** `|c|c|`, `\hline` sau mỗi hàng, tiêu đề cột **in đậm**, `\renewcommand{\arraystretch}{1.3}`.
2. **Tên bảng nằm TRÊN bảng**: `\caption` và `\label` đặt **trước** `\begin{tabular}`.
3. Luôn dùng `\begin{table}[H]` + `\centering`.
4. Cột có văn bản dài: `tabularx` với cột `X`, rộng `\textwidth`.
5. Bảng dài hơn 1 trang: `longtable` (xem `chapters/phuluc.tex`).
6. Đơn vị ghi ở tiêu đề cột trong ngoặc: `\textbf{$I$ (\unit{\milli\ampere})}`. Ô số liệu chỉ ghi số.
7. Số liệu cùng cột: cùng số chữ số thập phân.
8. Khuôn mẫu:
   ```latex
   \begin{table}[H]
       \centering
       \caption{Thông số kỹ thuật Load cell YZC-133}
       \label{tab:c2:thong-so-loadcell}
       \renewcommand{\arraystretch}{1.3}
       \begin{tabular}{|l|c|}
           \hline
           \textbf{Thông số} & \textbf{Giá trị} \\ \hline
           Tải trọng định mức & \qty{1}{\kilo\gram} \\ \hline
       \end{tabular}
   \end{table}
   ```

---

## 10. Trích dẫn, mã nguồn, danh sách, nhận xét

**Trích dẫn**
- Thêm entry vào `references/chuongN.bib`, key có tiền tố `cN_`. Trích dẫn: `\cite{cN_key}`.
- Mọi thông số lấy từ datasheet **phải** `\cite` datasheet đó.
- Không viết ký tự `@` trong dòng comment của file `.bib`.
- **Không** tự bịa tài liệu tham khảo. AI chỉ được tạo entry từ thông tin người dùng cung cấp (tên, link, năm). Thiếu thông tin thì để `\TODO{}`.

**Mã nguồn**: `lstlisting` với `language`, `caption`, `label={lst:cN:...}`. Code và comment trong code **không dấu**.

**Danh sách**: `itemize` / `enumerate`; liệt kê yêu cầu đề dùng `\begin{enumerate}[label=\alph*.]`. Mục danh sách dạng “**Tên:** mô tả” viết `\item \textbf{Tên:} mô tả.`

**Nhận xét**: `\nhanxet{...}`, nêu **số liệu cụ thể** và **so sánh với lý thuyết** (sai số %), không viết chung chung kiểu “kết quả đúng với tính toán”.

**Chưa xong**: `\TODO{...}`. Bản final không được còn `\TODO`.

---

## 11. Checklist trước khi commit

- [ ] Chỉ sửa đúng file/thư mục của mình (mục 2).
- [ ] Biên dịch `main.tex` **không lỗi** (warning `undefined reference` tới chương khác là chấp nhận được).
- [ ] Không có `\usepackage`, `\newcommand`, `\documentclass` trong file chương.
- [ ] Mọi label có đúng tiền tố `cN` (mục 4); không trùng label.
- [ ] Mọi hình/bảng/phương trình có `\label` và được `\ref` trong văn bản.
- [ ] Mọi ảnh nằm trong `image/chuongN/`, tên không dấu, đường dẫn có phần mở rộng, không còn khung “THIẾU ẢNH”.
- [ ] Bảng: caption ở trên, kẻ khung, tiêu đề in đậm, có đơn vị.
- [ ] Đơn vị dùng `\qty`/`\unit`, không gõ tay.
- [ ] Sau mỗi kết quả có `\nhanxet{}` kèm số liệu.
- [ ] Mọi thông số datasheet có `\cite`.
- [ ] Không còn `\TODO` (khi nộp bản final).
- [ ] Không commit file build (`.aux`, `.log`, `.pdf`, ...): đã có `.gitignore`.

---

## 12. Prompt mẫu cho AI

Copy nguyên khối dưới đây, điền các phần `<...>`:

```text
Bạn là trợ lý viết báo cáo kỹ thuật LaTeX tiếng Việt cho bài tập lớn môn Điện tử ứng dụng
(ĐH Bách Khoa TP.HCM). Tôi đính kèm:
  (1) report_guideline.md: bộ quy tắc BẮT BUỘC,
  (2) config/macros.tex: các macro được phép dùng,
  (3) template/chapter_template.tex: mẫu cú pháp chuẩn,
  (4) chapters/chuong<N>.tex: khung chương tôi phụ trách.

Nhiệm vụ: viết nội dung cho mục "<tên section>" của Chương <N> dựa trên thông tin kỹ thuật sau:
<dán số liệu, công thức, kết quả mô phỏng, tên file ảnh đã đặt trong image/chuong<N>/, link datasheet...>

Yêu cầu bắt buộc:
- Tuân thủ 100% report_guideline.md. Chỉ dùng macro có trong macros.tex và gói đã có trong preamble.
- Chỉ xuất code LaTeX để dán vào file chuong<N>.tex: KHÔNG \documentclass, \usepackage,
  \begin{document}, \newcommand.
- Giữ nguyên \chapter, các \section có sẵn và khối comment header.
- Label dạng fig:c<N>:..., tab:c<N>:..., eq:c<N>:..., sec:c<N>:...; key TLTK dạng c<N>_...
- Hình dùng \hinh / \haihinh, đường dẫn "chuong<N>/ten_file.png". Bảng caption ở trên, kẻ khung.
- Đơn vị dùng \qty{}{} / \unit{}. Mỗi kết quả có \nhanxet{} với số liệu cụ thể.
- KHÔNG bịa số liệu, kết quả đo, hay tài liệu tham khảo. Thiếu thông tin thì chèn \TODO{mô tả thứ cần bổ sung}.
- Nếu cần thêm entry .bib, xuất riêng ở cuối trong một khối code khác, chỉ dựa trên thông tin tôi cung cấp.
- Sau khi viết xong, tự rà lại theo Checklist mục 11 và liệt kê các \TODO còn lại.
```

---

## 13. Lỗi thường gặp

| Lỗi | Nguyên nhân | Cách sửa |
|---|---|---|
| `Undefined control sequence \qty` | Gõ sai tên lệnh đơn vị | Xem bảng mục 6 |
| `Label multiply defined` | Trùng label | Thêm/đổi tiền tố `cN`, đổi tên |
| Khung đỏ “THIẾU ẢNH” | Sai đường dẫn, thiếu đuôi, sai hoa/thường | Đường dẫn tính từ `image/`, có `.png`/`.jpg` |
| `Missing $ inserted` | `_` hoặc `^` ngoài môi trường toán | Đặt trong `$...$` hoặc escape `\_` |
| Hình/bảng hiển thị `??` | Chưa biên dịch đủ lần / label sai | Biên dịch lại 2 lần (latexmk tự làm) |
| Lỗi ký tự trong code listing | Có chữ có dấu trong `lstlisting` | Viết code/comment không dấu |
| BibTeX lỗi entry lạ | Có `@` trong comment `.bib` | Xóa `@` khỏi comment |

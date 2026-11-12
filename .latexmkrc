# latexmk config — chạy: latexmk main.tex
$pdf_mode = 1;            # pdfLaTeX
$bibtex_use = 2;          # chạy BibTeX khi cần
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
@default_files = ('main.tex');

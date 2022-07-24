let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

"let g:vimtex_compiler_method = 'arara'


let g:vimtex_compiler_latexmk_engines = {
	\ '_'                : '-pdf',
	\ 'pdflatex'         : '-pdf',
	\ 'dvipdfex'         : '-pdfdvi',
	\ 'lualatex'         : '-lualatex',
	\ 'xelatex'          : '-xelatex',
	\ 'context (pdftex)' : '-pdf -pdflatex=texexec',
	\ 'context (luatex)' : '-pdf -pdflatex=context',
	\ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
	\}

"这里是设置latexmk工具的可选参数
let g:vimtex_compiler_latexmk = {
	\ 'options' : [
	\   '-xelatex',
	\   '-verbose',
	\   '-file-line-error',
	\   '-synctex=1',
	\   '-interaction=nonstopmode',
	\ ],
	\}

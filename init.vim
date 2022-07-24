" 配置文件导入 "{{{
" ---------------------------------------------------------------------
" 基础使用习惯配置
runtime ./vimrc.vim
" 插件管理
"./lua/plugins.lua
lua require('plugins')
lua require('lspconf.setup')
" 按键映射
runtime ./maps.vim

" 添加配置文件
source ~/.config/nvim/after/plugin/airline.rc.vim
source ~/.config/nvim/after/plugin/rnvimr.rc.vim
source ~/.config/nvim/after/plugin/defx-icons.rc.vim
source ~/.config/nvim/colors/gruvbox_material.rc.vim

packadd! vimspector

autocmd BufNewFile *.sh,*.html,*.tex exec ":call SetTitle()"
"定义函数SetTitle，自动插入文件头"
func SetTitle()
    if expand ("%:e") == 'sh'
        call setline(1, "#!/bin/bash")
        call setline(2, "#Author:Zongyang")
        call setline(3, "#Blog:https://www.thetu.cn")
        call setline(4, "#Time:".strftime("%F %T"))
        call setline(5, "#Name:".expand("%"))
        call setline(6, "#Version:V1.0")
        call setline(7, "#Description:This is a production script.")
	"elseif expand ("%:e") == 'cc'||expand ("%:e")=='cpp'||expand ("%:e")=='h'||expand ("%:e")=='c'
		"call setline(1, "/*")
		"call setline(2, "  The BSD License(BSD)")
		"call setline(3, "") 
		"call setline(4, "  Copyright (c) 2021 Zongyang")
		"call setline(5, "  Author:Zongyang")
		"call setline(6, "  Date:".strftime("%F"))
		"call setline(7, "  Version:0.1.0")
		"call setline(8, "*/")
		"if expand ("%:e") == 'h'
			"let file_name = expand("%:t:r")
			"let file_name = toupper(file_name)
			"call setline(9,"#ifndef ".file_name."_H")
			"call setline(10,"#define ".file_name."_H")
			"call setline(11,"")
			"call setline(12,"#endif")
		"endif
    elseif expand("%:e") == 'html'
        call setline(1, "<!DOCTYPE html>")
        call setline(2,"<html>")
        call setline(3,"    <head>")
        call setline(4,"    <meta charset='utf=8'>")
        call setline(5,"    </head>")
        call setline(6,"    <body>")
        call setline(7,"        ")
        call setline(8,"    </body>")
        call setline(9,"</html>")
	elseif expand("%:e") == 'tex'
		call setline(1, "% !TEX program = xelatex")
    endif
endfunc

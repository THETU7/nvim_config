" Split window
nmap ss :split<Return>
nmap sv :vsplit<CR>

" Move window
nmap sh <C-w>h
nmap sj <C-w>j
nmap sk <C-w>k
nmap sl <C-w>l


" Save
noremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" 退出
map Q :q<CR>
" 重新加载
map R :source $MYVIMRC<CR>

nmap <C-a> gg<S-v>G

" Resize window
" 在mac/linux中使用Alt键，在webssh
" 中alt没用，就使用Ctrl,WEBSSH主要的WINDOWS中使用
nmap <M-left> <C-w><
nmap <C-left> <C-w><
nmap s<left> <C-w><

nmap <M-right> <C-w>>
nmap <C-right> <C-w>>
nmap s<right> <C-w>>

nmap <M-up> <C-w>+ 
nmap <C-up> <C-w>+
nmap s<up> <C-w>+

nmap <M-down> <C-w>-
nmap <C-down> <C-w>-
nmap s<down> <C-w>-

" 插入模式移动光标
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-d> <Delete>

" tab缩进
nmap <tab> V>
nmap <s-tab> V<
vmap <tab> >gv
vmap <s-tab> <gv

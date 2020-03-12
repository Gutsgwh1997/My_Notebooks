"===
"=== 基本设置
"===
" 关闭vi的一致性模式 避免以前版本的一些Bug和局限  
set nocompatible  
" 显示行号  
set number  
" 突出当前行
set cursorline
" 相对行数
set relativenumber
" 设置在编辑过程中右下角显示光标的行列信息  
set ruler  
set ma
" 在状态栏显示正在输入的命令  
set showcmd
" 设置历史记录条数  
set history=1000
" 设置取消备份 禁止临时文件生成  
set nobackup  
set noswapfile  
" 设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号  
set showmatch
" 短暂跳转到匹配括号的时间
set matchtime=1
" 设置C/C++方式自动对齐  
set autoindent  
set cindent
set hidden
" 开启新行时使用智能自动缩进
set smartindent
" 搜索时高亮显示被找到的文本
set hlsearch
exec "nohlsearch"
set incsearch
" 设置在Vim中可以使用鼠标 
set mouse=a
" 设置Tab宽度  
set tabstop=4
" 设置将Tab自动转换为空格
set expandtab
" 增加缩进
set shiftwidth=4
" 字符过长会换行
set wrap
" 给个菜单让你选择
set wildmenu
" 忽略大小写
set ignorecase
" 智能大小写
set smartcase
" 开启语法高亮功能  
syntax on

let mapleader =" "
" ===
" === Cursor Movement
" ===
" "     ^
" "     i
" " < j   l >
" "     k
" "     v
noremap h i
noremap H I
noremap j <left>
noremap k <down>
noremap i <up>
map lg ^
map le $

"===
"=== 分屏操作
"===
" Split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap si :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sk :set splitbelow<CR>:split<CR>
noremap sj :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>
" Resize splits with arrow keys
noremap <LEADER><up> :res +5<CR>
noremap <LEADER><down> :res -5<CR>
noremap <LEADER><left> :vertical resize-5<CR>
noremap <LEADER><right> :vertical resize+5<CR>
" Move around several wondows
nnoremap <C-K> <C-W><C-J>
nnoremap <C-I> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-J> <C-W><C-H>
" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>

"===
"=== 其他的快捷键
"===
" Copy to system clipboard
vnoremap Y "+y
noremap P "+p
" 取消搜索后的高亮
noremap <LEADER><CR> :nohlsearch<CR>
" Buffer的一些操作
noremap <LEADER>j :bNext<CR>
noremap <LEADER>l :bnext<CR>
noremap <LEADER>d :bdelete<CR>
" 数字加一，默认<C-a>，与tmux冲突
map = <C-a>
map - <C-x>
" 删除所有的书签
noremap <LEADER>md :delm!<CR>
" 保存与退出
map S :w<CR>
map Q :q<CR>
map RE :source $MYVIMRC<CR>
" 在当前行上方添加空行，可以接数字
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" 当前行上\下移
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>
" 交换CapsLock与CapsLock的键位
" au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
" au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'


" 窗口最大化
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose
        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction
nmap <leader>z :call Zoom()<CR>


" Compile function
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w" 
    if &filetype == 'c' 
        exec '!g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'cpp'
        set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
        :sp
        :res -15
        :term ./%<
    elseif &filetype == 'python'
        exec '!time ~/anaconda3/envs/python36/bin/python3.6 %'
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    endif                                                                              
endfunc 

"===
"=== 插件安装
"===
call plug#begin('~/.vim/plugged')
" Beautiful Dress
Plug 'connorholyday/vim-snazzy'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Document Manager
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
" Auto Code
Plug 'Valloric/YouCompleteMe'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-clang-format'
Plug 'tell-k/vim-autopep8'
Plug 'scrooloose/nerdcommenter' 
Plug 'Raimondi/delimitMate'
" Git 
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Markdown
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'dhruvasagar/vim-table-mode'
" 对齐指示线条
Plug 'Yggdroot/indentLine', {'for':['python']} 
" Plug 'nathanaelkane/vim-indent-guides'
" 多彩括号
Plug 'luochen1990/rainbow'
" 剪切板提示
Plug 'junegunn/vim-peekaboo'
" Bookmarks
Plug 'kshenoy/vim-signature'
" FZF
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
" Leetcode
" Plug 'ianding1/leetcode.vim'
call plug#end()

"===
"=== Markdown Preview
"===
let g:mkdp_auto_close = 1
let g:mkdp_page_title = '「${name}」'
nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode

"===
"=== vim-table-mode
"===
map <LEADER>tm :TableModeToggle<CR>
let g:table_mode_auto_align = 0
autocmd FileType markdown
        \ let g:table_mode_corner = "|" |
        \ let g:table_mode_corner_corner = "|" |
        \ let g:table_mode_header_fillchar = "-" |
        \ let g:table_mode_align_char = ":"

"===
"=== 注释插件,加半个空格
"===
let g:NERDSpaceDelims=1
"<LEADER> cc 紧贴着代码加注释
"<LEADER> cb 在代码最前端加注释
"<LEADER> cu 取消注释

"===
"=== gitgutter
"===
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)

"===
"=== clang-format
"===
autocmd FileType c,cpp,objc nnoremap <buffer><C-h> :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><C-h> :ClangFormat<CR>
let g:clang_format#style_options = {
            \ "AlignTrailingComments" : "true",
            \ "ColumnLimit" : 110,
            \ "PointerAlignment" : "Right",
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlignConsecutiveAssignments" : "true",
            \ "BreakConstructorInitializersBeforeComma" : "true",}
" python-format
autocmd FileType python nnoremap <buffer><C-h> :call Autopep8()<CR>
autocmd FileType python vnoremap <buffer><C-h> :call Autopep8()<CR>
let g:autopep8_disable_show_diff=1
let g:autopep8_diff_type='vertical'

"===
"=== Doxygen
"===
nmap fil :DoxAuthor<CR>
nmap fun :Dox<CR>

"===
"=== NERDTree
"===
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
""修改树的显示图标
"let g:NERDTreeDirArrowExpandable = '+'
"let g:NERDTreeDirArrowCollapsible = '-'
""窗口位置
let g:NERDTreeWinPos='left'
""窗口是否显示行号
let g:NERDTreeShowLineNumbers=0
""不显示隐藏文件
let g:NERDTreeHidden=0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
""打开vim时如果没有文件自动打开NERDTree
autocmd vimenter * if !argc()|NERDTree|endif
""当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"更改常用键位
let g:NERDTreeMapOpenSplit = "h"
let g:NERDTreeMenuDown = "k"
let g:NERDTreeMenuUp = "i"

"NerdTree git的配置
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

"===
"=== tagbar
"===
let g:tagbar_ctags_bin = 'ctags' " tagbar 依赖 ctags 插件
let g:tagbar_width     = 30      " 设置 tagbar 的宽度为 30 列，默认 40 列
let g:tagbar_autofocus = 1       " 打开 tagbar 时光标在 tagbar 页面内，默认在 vim 打开的文件内
let g:tagbar_left      = 0       " 让 tagbar 在页面左侧显示，默认右边
"let g:tagbar_sort      = 0      " 标签不排序，默认排序
let g:tagbar_map_togglecaseinsensitive = "H"
map <F4> :TagbarToggle<CR>

"===
"=== YouCompleteMe
"===
" 配置默认文件路径
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" python版本的选择
let g:ycm_server_python_interpreter='/usr/bin/python3.5'
" turn off YCM
nnoremap <leader>b :let g:ycm_auto_trigger=0<CR>                
" turn on YCM
nnoremap <leader>B : let g:ycm_auto_trigger=1<CR>               
" 打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_confirm_extra_conf = 0
" 字符串中也开启补全
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
" 开始补全的字符数
let g:ycm_min_num_of_chars_for_completion = 2 
" 补全后自动关闭预览窗口
let g:ycm_autoclose_preview_window_after_completion = 1
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
" 在实现和声明之间跳转,并分屏打开
let g:ycm_goto_buffer_command = 'horizontal-split'
" 关闭语法检查器
let g:ycm_show_diagnostics_ui = 1 
" 跳转到定义
nnoremap <Leader>g :YcmCompleter GoTo<CR>
" Fixit
nnoremap <Leader>y :YcmCompleter FixIt<CR>
"let g:ycm_key_list_stop_completion = ['<CR>']
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
"配合CMake使用，在CMakeList中添加
"set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
"并将ycm_extra_conf.py拷贝到../build
"在其中的compilation_database_folder添加./build目录

"===
"=== gitgutter
"===
set updatetime=100

"===
"=== 对齐线条
"===
"使用主题的颜色
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"另一个对齐参考线
let g:indent_guides_enable_on_vim_startup = 1    
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 1

"===
"=== rainbow
"===
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

"===
"=== Python-syntax
"===
let g:python_highlight_all = 1

"===
"=== FZF
"===
nnoremap <silent> <C-f> :Files<CR>

"===
"=== leetcode
"===
let g:leetcode_browser = 'chrom'
let g:leetcode_china = 0
let g:leetcode_username = 'guanwenhao55@163.com'
let g:leetcode_password = ''

"===
"=== 主题设置
"===
set t_Co=256
" snazzy透明
let g:SnazzyTransparent = 1
let g:airline#extensions#tabline#enabled = 1
" molokai
"colorschem molokai
let g:rehash256 = 1
let g:molokai_original = 1
" gruvbox 
colorscheme gruvbox
set background=dark
highlight Normal guibg=NONE ctermbg=None

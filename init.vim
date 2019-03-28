" dein.vimによるプラグイン管理
if &compatible
  set nocompatible
endif

" dein.vimのclone先を指定する
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state($HOME . '/.cache/dein')
  let g:dein#cache_directory = $HOME . '/.cache/dein'

  call dein#begin($HOME . '/.cache/dein')

  let s:toml_dir  = $HOME . '/.config/nvim/dein/toml'
  let s:toml      = s:toml_dir . '/dein.toml'
  let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

call map(dein#check_clean(), "delete(v:val, 'rf')")

"End dein Scripts-------------------------

" 挿入モードでTABキーを押した際、対応する数のスペースを入力
set expandtab
" 外部でファイルに変更がされた場合は読み直す
set autoread
" 画面上でタブ文字が占める幅の指定
set tabstop=2
" 自動インデントでずれる幅の指定
set shiftwidth=2
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅の指定
set softtabstop=2
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 一旦ファイルタイプ関連を無効化
filetype off
" 256色対応
set t_Co=256
" エンコード, ファイルエンコード
set encoding=utf-8
set fileencoding=utf-8
" スクロールする時に下が見えるようにする
set scrolloff=5
" .swapファイルを作らない
set noswapfile
" バックアップファイルを作らない
set nowritebackup
" バックアップをしない
set nobackup
" ビープ音を消す
set belloff=all
" OSのクリップボードを使う
set clipboard=unnamed
" 行番号を表示
set number
" compatibleオプションをオフにする
set nocompatible
" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline
" 対応括弧に<と>のペアを追加
set matchpairs& matchpairs+=<:>
" 対応括弧をハイライト表示する
set showmatch
" 対応括弧の表示秒数を3秒にする
set matchtime=3
" ウィンドウの幅より長い行は折り返され、次の行に続けて表示される
set wrap
" 入力されているテキストの最大幅を無効にする
set textwidth=0
" 不可視文字を表示
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" インデントをshiftwidthの倍数に丸める
set shiftround
" 補完の際の大文字小文字の区別しない
set infercase
" 行末1文字までカーソルを移動できるようにする
set virtualedit=onemore
" 変更中のファイルでも、保存しないで他のファイルを表示
set hidden
" 新しく開く代わりにすでに開いてあるバッファを開く
set switchbuf=useopen
" 小文字の検索でも大文字も見つかるようにする
set ignorecase
" ただし大文字も含めた検索の場合はその通りに検索する
set smartcase
" インクリメンタルサーチを行う
set incsearch
" 検索結果をハイライト表示
set hlsearch
" マウスモード有効
set mouse=a
" コマンドを画面最下部に表示する
set showcmd
" ◆や○文字が崩れる問題を解決"
set ambiwidth=double

" インサートモードでbackspaceを有効に
set backspace=indent,eol,start
" 入力モード中に素早くjjと入力した場合はESCとみなす
" inoremap jj <Esc>
" ビジュアルモードの選択範囲を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
" vを二回で行末まで選択
vnoremap v $h
" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" /{pattern}の入力中は「/」をタイプすると自動で「\/」が、
" ?{pattern}の入力中は「?」をタイプすると自動で「\?」が 入力されるようになる
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" カラースキーマ
colorscheme alduin
" シンタックスハイライトの最大行数
set synmaxcol=200
" シンタックスハイライト
syntax on
" .vueシンタックスハイライト
autocmd BufNewFile,BufRead *.vue set filetype=html
" 全角スペースのハイライト
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" for lightline.vim
set laststatus=2
set statusline=%F
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['fugitive', 'readonly', 'fullpathfilename', 'anzu']
  \   ]
  \ },
  \ 'component_function': {
  \   'anzu': 'anzu#search_status',
  \   'fugitive': 'MyFugitive',
  \   'fullpathfilename': 'LightlineFilename'
  \ }
  \ }

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && strlen(fugitive#head())
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" 画面分割
nnoremap s <Nop>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>

nnoremap <C-a> ^
nnoremap <C-e> $

"visual mode行頭へ移動
vnoremap <C-a> ^
"行末へ移動
vnoremap <C-e> $

"行頭へ移動
inoremap <C-a> <C-o>^
"行末へ移動
inoremap <C-e> <C-o>$

inoremap * <C-o>o

map <C-t> :NERDTreeToggle<CR>

nnoremap Q <Nop>

nnoremap gG :grep '\b<cword>\b'<CR>\|:if len(getqflist())\|:botright copen 3\|else\|ccl\|endif\|cc<CR>
set grepprg=git\ grep\ -n\ $*\ --\ $(git\ rev-parse\ --show-cdup)

" 最後のカーソル位置復元
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


nmap <Tab> gt
nmap <S-Tab> gT

" ctrlp.vim gitignoreしたファイルは検索しない
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" nepcomplete.vim
let g:neocomplete#enable_at_startup = 1

set wildmenu
set wildmode=list:longest

autocmd QuickFixCmdPost *grep* cwindow

" ctrlp設定
" デフォルトのマッピングを無効化(default:'<C-p>')
" let g:ctrlp_map = '<Nop>'

" 対象ファイル最大数(default:10000)
let g:ctrlp_max_files  = 100000

" 検索対象の最大階層数(default:40)
let g:ctrlp_max_depth = 10

" 遅延再描画
let g:ctrlp_lazy_update = 1

" vim終了時にキャッシュクリアしない(default:1)
let g:ctrlp_clear_cache_on_exit = 0

" 検索ウィンドウの設定
" :help g:ctrlp_match_window
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'

" カレントディレクトリを基準に検索
nnoremap <silent> <Space>cf :CtrlPCurWD<CR>

" カレントバッファのルートディレクトリを基準に検索(root:自動認識)
nnoremap <silent> <Space>cF :CtrlPRoot<CR>

" 最近使ったファイルから検索
nnoremap <silent> <Space>cr :CtrlPMRUFiles<CR>

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

autocmd FileType vue syntax sync fromstart

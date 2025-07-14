" Vim starting {{{
if has('vim_starting')
    set undodir=$HOME/.vim/undo
    if v:servername !~ '.*[0-9]$'
        silent! execute '!rm -rf "'.$HOME.'/.vim/vimtemp"'
        silent! execute '!mkdir "'.$HOME.'/.vim/vimtemp"'
    endif
    set backupdir=$HOME/.vim/vimtemp//
    set directory=$HOME/.vim/vimtemp//
    set spellfile=$HOME/.vim/en.utf-8.add
    set undofile
    if isdirectory(expand('~/Documents/src/vim_plugins'))
        set packpath+=~/Documents/src/vim_plugins
    endif
    syntax off
    filetype plugin indent on
endif
" }}}

" Globals {{{
let readline_has_bash = 1
let g:airline_powerline_fonts = 1
" }}}

" Helper functions {{{
function! MyHexToggle()
    if !&binary
        setlocal binary
        setlocal nonumber
        let l:modified = &modified
        %!xxd
        if &ft
            let b:filetype = &ft
        endif
        setlocal ft=xxd
        let &modified = l:modified
    else
        setlocal nobinary
        setlocal number
        let l:modified = &modified
        %!xxd -r
        if exists('b:filetype')
            let &ft=b:filetype
        else
            setlocal ft=
        endif
        let &modified = l:modified
    endif
endfunction

function! MySkeleton()
    let l:skelfiles = glob('~/.vim/skel/*.skel', v:false, v:true)
    let l:idx = 1
    let l:msg = 'Available licenses:'
    for l:skelfile in l:skelfiles
        let l:msg .= "\n\t".l:idx."\t".l:skelfile
        let l:idx += 1
    endfor
    let l:msg .= "\n\t".l:idx."\tNone"
    echo l:msg
    let l:selection = 0
    while l:selection < 1 || l:selection > l:idx
        let l:selection = input("Use license: ")
    endwhile
    if l:selection == l:idx
        return
    endif
    let l:skel = readfile(l:skelfiles[l:selection - 1])
    let l:comments = split(&comments, ',')
    let l:idx = 0
    let l:firstcomment = ''
    let l:comment = ''
    let l:endspace = ''
    let l:lastcomment = ''
    let l:space = ''
    for l:token in l:comments
        if l:token =~ '^s[^O]'
            let l:firstcomment = substitute(l:token, '^s.*:', '', '')
            let l:comment = substitute(l:comments[l:idx + 1], '^m.*:', '', '')
            if l:token =~ '^sr'
                let l:offset = len(l:firstcomment) - len(l:comment)
                let l:comment = repeat(' ', l:offset) . l:comment
                let l:endspace = repeat(' ', l:offset)
            endif
            let l:lastcomment = substitute(l:comments[l:idx + 2], '^e.*:', '', '')
            let l:space = (l:comments[l:idx + 1] =~ '^mb') ? ' ' : ''
            break
        elseif l:token =~ '^b\?:'
            let l:comment = substitute(l:token, '^b\?:', '', '')
            let l:firstcomment = l:comment
            let l:lastcomment = l:comment
            let l:rightalign = v:false
            let l:space = (l:token =~ '^b') ? ' ' : ''
            break
        endif
        let l:idx += 1
    endfor
    let l:idx = 0
    for l:line in l:skel
        if l:line =~ "^$"
            let l:line = l:comment
        else
            let l:line = l:comment . l:space . l:line
        endif
        let l:line = substitute(l:line, '{{ year }}', "\\=strftime('%Y')", '')
        let l:skel[l:idx] = l:line
        let l:idx += 1
    endfor
    let l:skel = [l:firstcomment] + l:skel + [l:endspace . l:lastcomment]

    let l:lines = join(l:skel, "\n")
    silent execute '0put =printf(\"%s\", l:lines)'
    set modified
    normal G
endfunction

function! InitializeClasspath()
    if(filereadable('.vim_java_classpath'))
        so .vim_java_classpath
    endif
endfunction

function! BuildJavaMakeprg()
    if exists('b:vim_java_classpath')
        let &makeprg = &makeprg.' -cp '.b:vim_java_classpath
    endif
endfunction
" }}}

" Commands {{{
" }}}

" Auto-commands {{{
augroup myvimrc
    autocmd!
    autocmd BufWritePost *imrc so %
    autocmd VimResized * wincmd =
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
    autocmd QuickFixCmdPre [^l]* nested silent! cclose
    autocmd QuickFixCmdPre    l* nested silent! lclose
    autocmd BufNewFile Makefile,*.py,*.cpp,*.java,LICENSE call MySkeleton()
    autocmd VimEnter * let w:active_window = 1
    autocmd WinEnter * let w:active_window = 1
    autocmd WinLeave * unlet! w:active_window
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END
" }}}

" Key mappings {{{
let mapleader=";"
nnoremap rc :New $MYVIMRC<CR>
nnoremap <Leader>g :GrepJob!<Space>
nnoremap <Leader>' :vnew<CR>
nnoremap <Leader>- :new<CR>
nnoremap <Leader>e :e **/
nnoremap <Leader>s :call MyScratchBuffer()<CR>
nnoremap <Leader>n :New<Space>
nnoremap <Leader>h :Help<Space>
nnoremap <Leader>l :ls<CR>:b
nnoremap <Leader>L :ls<CR>:Buffer
nnoremap <leader>b :Buffer<Space>
nnoremap <leader>x :call MyHexToggle()<CR>
nnoremap <Leader>o :execute 'silent !my-open '
            \ .expand(shellescape('<cWORD>')) \| redraw!<CR>
nnoremap <Leader>c :silent! execute 'cclose' \|
            \ silent! execute 'lclose'<CR>
nnoremap <F4> :setlocal spell spelllang=en_us<CR>
nnoremap <F5> :nohl<CR>
nnoremap <F6> :call MySkeleton()<CR>
nnoremap <F8> :Goyo<CR>
if has('win32') || has('win64')
    nnoremap <F9> :Neomake!<CR>
else
    nnoremap <F9> :Neomake!<CR>
endif
" }}}

" General options {{{
if system("dark-mode status") =~ "off"
    colorscheme djmoch
else
    colorscheme apprentice
endif
set ttyfast
set nowrap
set noshowmode
set showcmd
set textwidth=72
set autoindent
set visualbell
set smartcase
set number
set foldmethod=marker
set ttimeoutlen=0
set laststatus=2
set wildmenu
set wildmode=longest:full,full
set nofileignorecase
set history=10000
set hlsearch
set incsearch
set mouse=a
set backspace=indent,eol,start
set backup
set wildignore+=tags,*.class,*.pyc,*.pyo,__pycache__,*.o
set grepprg=ag\ --vimgrep\ -p\ ~/.cvsignore\ $*
set grepformat=%f:%l:%c:%m
set viminfo+=n$HOME/.vim/viminfo
set autowrite
if $SHELL =~ 'zsh' || $SHELL =~ 'bash'
    set title
endif
let &titlestring=hostname() . ':%t%h'
" }}}

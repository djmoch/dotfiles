" Break on non-comment lines (t) and insert a comment character (r)
setlocal formatoptions+=tr

" Always set the compiler
compiler rustc

" Customize compiler if we're working on a crate
set makeprg=cargo\ clippy

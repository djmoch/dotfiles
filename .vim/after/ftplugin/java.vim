" Break for code lines too
setlocal fo+=t

" Reduce tab size for Java
setlocal sts=2 sw=2

" Wider text width for Java
setlocal tw=120

compiler javac

execute InitializeClasspath() | execute BuildJavaMakeprg()

let &comments='sr:/*,mb:*,ex:*/,b://'

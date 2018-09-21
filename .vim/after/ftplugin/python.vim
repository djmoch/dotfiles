" Break for non-comment lines (t), and insert comment char (r)
setlocal fo+=tr

" Always set the compiler
compiler pylint

" Check if Pipenv is available, and adjust makeprg if it is
if(filereadable('Pipfile'))
    let &makeprg= 'pipenv run '.&makeprg
endif

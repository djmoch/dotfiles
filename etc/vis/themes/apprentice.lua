-- Eight-color scheme
local lexers = vis.lexers
-- apprentice
lexers.STYLE_DEFAULT      = ''
lexers.STYLE_NOTHING      = ''
lexers.STYLE_CLASS        = 'fore:#8787af'
lexers.STYLE_COMMENT      = 'fore:#6c6c6c'
lexers.STYLE_CONSTANT     = 'fore:#ff8700'
lexers.STYLE_DEFINITION   = ''
lexers.STYLE_ERROR        = 'fore:#af5f5f'
lexers.STYLE_FUNCTION     = 'fore:#ffffaf'
lexers.STYLE_KEYWORD      = 'fore:#87afd7'
lexers.STYLE_LABEL        = lexers.STYLE_KEYWORD
lexers.STYLE_NUMBER       = lexers.STYLE_CONSTANT
lexers.STYLE_OPERATOR     = lexers.STYLE_KEYWORD
lexers.STYLE_REGEX        = 'fore:#87af87'
lexers.STYLE_STRING       = lexers.STYLE_REGEX
lexers.STYLE_PREPROCESSOR = 'fore:#5f8787'
lexers.STYLE_TAG          = 'fore:#5f875f'
lexers.STYLE_TYPE         = lexers.STYLE_CLASS
lexers.STYLE_VARIABLE     = ''
lexers.STYLE_WHITESPACE   = ''
lexers.STYLE_EMBEDDED     = ''
lexers.STYLE_IDENTIFIER   = 'fore:#5f87af'

lexers.STYLE_LINENUMBER        = 'back:black,fore:white'
lexers.STYLE_LINENUMBER_CURSOR = lexers.STYLE_LINENUMBER
lexers.STYLE_CURSOR            = 'reverse'
lexers.STYLE_CURSOR_PRIMARY    = lexers.STYLE_CURSOR..',fore:yellow'
lexers.STYLE_CURSOR_LINE       = 'back:#303030'
lexers.STYLE_COLOR_COLUMN      = 'back:#1c1c1c'
lexers.STYLE_SELECTION         = 'back:white'
lexers.STYLE_STATUS            = 'back:#444444,fore:yellow'
lexers.STYLE_STATUS_FOCUSED    = 'back:default,fore:yellow,reverse'
lexers.STYLE_SEPARATOR         = 'back:black,fore:black'
lexers.STYLE_INFO              = 'fore:default,back:default,bold'
lexers.STYLE_EOF               = 'fore:#585858'

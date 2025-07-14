-- Eight-color scheme
local lexers = vis.lexers
-- djmoch
lexers.STYLE_DEFAULT      = ''
lexers.STYLE_NOTHING      = ''
lexers.STYLE_CLASS        = 'fore:magenta'
lexers.STYLE_COMMENT      = 'fore:green'
lexers.STYLE_CONSTANT     = 'fore:red'
lexers.STYLE_DEFINITION   = ''
lexers.STYLE_ERROR        = 'fore:red,reverse'
lexers.STYLE_FUNCTION     = 'fore:green'
lexers.STYLE_KEYWORD      = 'fore:blue'
lexers.STYLE_LABEL        = lexers.STYLE_KEYWORD
lexers.STYLE_NUMBER       = lexers.STYLE_CONSTANT
lexers.STYLE_OPERATOR     = lexers.STYLE_KEYWORD
lexers.STYLE_REGEX        = lexers.STYLE_CONSTANT
lexers.STYLE_STRING       = lexers.STYLE_CONSTANT
lexers.STYLE_PREPROCESSOR = 'fore:magenta'
lexers.STYLE_TAG          = 'fore:blue'
lexers.STYLE_TYPE         = lexers.STYLE_CLASS
lexers.STYLE_VARIABLE     = ''
lexers.STYLE_WHITESPACE   = ''
lexers.STYLE_EMBEDDED     = ''
lexers.STYLE_IDENTIFIER   = ''

lexers.STYLE_LINENUMBER        = 'back:white,fore:black'
lexers.STYLE_LINENUMBER_CURSOR = lexers.STYLE_LINENUMBER
lexers.STYLE_CURSOR            = 'back:default,fore:default,reverse'
lexers.STYLE_CURSOR_PRIMARY    = lexers.STYLE_CURSOR..',fore:yellow'
lexers.STYLE_CURSOR_LINE       = 'back:white,fore:black'
lexers.STYLE_COLOR_COLUMN      = 'reverse'
lexers.STYLE_SELECTION         = 'back:white'
lexers.STYLE_STATUS            = 'fore:blue,italics'
lexers.STYLE_STATUS_FOCUSED    = 'back:default,fore:blue,reverse'
lexers.STYLE_SEPARATOR         = lexers.STYLE_DEFAULT
lexers.STYLE_INFO              = 'fore:default,back:default,bold'
lexers.STYLE_EOF               = 'fore:blue'

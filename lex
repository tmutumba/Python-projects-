
# CS3210 - Principles of Programming Languages - Fall 2019
# A Lexical Analyzer for an expression

from enum import Enum
import sys

# all char classes
class CharClass(Enum):
    EOF        = 1
    LETTER     = 2
    DIGIT      = 3
    OPERATOR   = 4
    PUNCTUATOR = 5
    QUOTE      = 6
    BLANK      = 7
    OTHER      = 8

# reads the next char from input and returns its class
def getChar(input):
    if len(input) == 0:
        return (None, CharClass.EOF)
    c = input[0].lower()
    if c.isalpha():
        return (c, CharClass.LETTER)
    if c.isdigit():
        return (c, CharClass.DIGIT)
    if c == '"':
        return (c, CharClass.QUOTE)
    if c in ['+', '-', '*', '/', '>', '=', '<', '(', ')']:
        return (c, CharClass.OPERATOR)
    if c in ['.', ':', ',', ';']:
        return (c, CharClass.PUNCTUATOR)
    if c in [' ', '\n', '\t']:
        return (c, CharClass.BLANK)
    return (c, CharClass.OTHER)

# calls getChar and getChar until it returns a non-blank
def getNonBlank(input):
    ignore = ""
    while True:
        c, charClass = getChar(input)
        if charClass == CharClass.BLANK:
            input, ignore = addChar(input, ignore)
        else:
            return input

# adds the next char from input to lexeme, advancing the input by one char
def addChar(input, lexeme):
    if len(input) > 0:
        lexeme += input[0]
        input = input[1:]
    return (input, lexeme)

# all tokens
class Token(Enum):
    ADD_OP     = 1
    SUB_OP     = 2
    MUL_OP     = 3
    DIV_OP     = 4
    IDENTIFIER = 5
    LITERAL    = 6
    bracket_OP = 7
    bracket_OP1 = 8
    EQ_OP      = 9
    Greater_OP = 10
    Less_OP    = 11

# lexeme to token conversion
lookup = {
    "+"      : Token.ADD_OP,
    "-"      : Token.SUB_OP,
    "*"      : Token.MUL_OP,
    "/"      : Token.DIV_OP,
    "("      : Token.bracket_OP,
    ")"      : Token.bracket_OP1,
    "="      : Token.EQ_OP,
    ">"      : Token.Greater_OP,
    "<"      : Token.Less_OP
}

# returns the next (lexeme, token) pair or None if EOF is reached
def lex(input):
    input = getNonBlank(input)

    c, charClass = getChar(input)
    lexeme = ""

    # check EOF first
    if charClass == CharClass.EOF:
        return (input, None, None)

    # TODO: reading letters
    if charClass == charClass.LETTER:
        input, lexeme = addChar(input, lexeme)
        return (input, lexeme, Token.IDENTIFIER)


    # TODO: reading digits
    if charClass == charClass.DIGIT:
        input, lexeme = addChar(input, lexeme)
        while (True):
            c, charClass = getChar(input)
            if charClass == charClass.DIGIT:
                input, lexeme = addChar(input, lexeme)
            else:
                return (input, lexeme, Token.LITERAL)

    # TODO: reading an operator
    if charClass == charClass.OPERATOR:
        input, lexeme = addChar(input, lexeme)
        return (input, lexeme, lookup[c])


    # TODO: anything else, raise an exception
    raise Exception("Lexical Analyzer cannot recognize symbol")
    

# main
if __name__ == "__main__":

    # checks if source file was passed and if it exists
    if len(sys.argv) != 2:
        raise ValueError("Missing source file")
    source = open(sys.argv[1], "rt")
    if not source:
        raise IOError("Couldn't open source file")
    input = source.read()
    source.close()
    output = []

    # main loop
    while True:
        input, lexeme, token = lex(input)
        if lexeme == None:
            break
        output.append((lexeme, token))

    # prints the output
    for (lexeme, token) in output:
        print(lexeme, token)

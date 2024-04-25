This repository contains the lexer and parser implementations for the PMF0 language.

##Instalation
-Install flex and bison tools, and 32bit gcc
-Clone git repository

##Language explanation:
Lexical Characteristics:
Keywords: Reserved keywords are indicated in uppercase letters. They cannot be used as identifiers or redefined.
Identifier: A sequence of letters, digits, and underscores that starts with a letter. "Pmf0" is case-sensitive, meaning "if" is a keyword, but "IF" is an identifier. Identifiers can be up to 31 characters long.
Whitespace: Spaces, tabs, and newlines separate tokens but are otherwise ignored. Keywords and tokens must be separated by whitespace or a token that is neither a keyword nor an identifier. For example, "ifintthis" is one identifier, not three keywords, while "if(23this" represents four tokens.
Boolean Constant: Either "true" or "false", and these words are reserved.
Integer Constant: It can be decimal (base 10) or hexadecimal (base 16). A decimal constant is a sequence of digits (0-9). A hexadecimal constant must start with "0X" or "0x", followed by a sequence of hexadecimal digits (decimal digits and the letters a-f, uppercase or lowercase). Examples of valid integer constants: 8, 012, 0x0, 0X12aE.
Double Constant: A sequence of digits followed by a dot, followed by possibly an empty sequence of digits. Thus, ".12" is not a valid double constant, but "0.12" and "12." are valid. A double can have an optional exponent, for example, "12.2E+2". In this notation, the dot is mandatory, the sign is optional (if absent, it defaults to +), and "E" can be lowercase or uppercase. "12E+2" is not valid, but "12.E+2" is. Leading zeros in the mantissa and exponent are allowed.
String Constant: A sequence of characters enclosed in double quotes and can contain any characters except newline and double quotes. The string must start and end on the same line.
Operators and Punctuation Marks:
Arithmetic operators: + - * / % \
Comparison operators: < <= > >= = == !=
Logical operators: && || !
Other punctuation marks: ; , . ( )
Single-Line Comment: Begins with "//".
Multi-Line Comment: Begins with "/" and ends with the first subsequent "/". All symbols are allowed in comments, except the sequence "*/" which terminates the comment. Nesting comments is not possible.
These lexical characteristics define the structure and rules for tokenizing input in the "pmf0" language.

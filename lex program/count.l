%{
int charCount = 0;
int wordCount = 0;
int lineCount = 0;
%}

%%

"/*"    {   /* Start of a comment */
            int commentDepth = 1;
            while(commentDepth > 0) {
                char c = input();
                if (c == '\n')
                    lineCount++;
                if (c == '*' && input() == '/') {
                    commentDepth--;
                }
            }
        }

"//"    {   /* Single line comment */
            while(input() != '\n');
            lineCount++;
        }

[ \t\n]+    {   /* Ignore spaces, tabs, and newlines */
                charCount += yyleng;
            }

[A-Za-z_][A-Za-z0-9_]*   {   /* Identifiers or keywords */
                                wordCount++;
                                charCount += yyleng;
                            }

.       {   /* Other characters */
            charCount++;
        }

%%
int yywrap()
{
return 1;
}
int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input_file>.c\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        printf("Error opening file.\n");
        return 1;
    }

    yyin = file;

    yylex();

    printf("Number of characters: %d\n", charCount);
    printf("Number of words: %d\n", wordCount);
    printf("Number of lines: %d\n", lineCount);

    fclose(file);
    return 0;
}
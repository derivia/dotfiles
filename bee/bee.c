// Read lines til EOF
/* 
char *line = NULL;
size_t len = 0;
size_t read;
while ((read = getline(&line, &len, stdin)) != -1) { }
*/

// Read line til '\n'
/*
void read_line(char *str)
{
  scanf(" %[^\n]", str);
}
*/

/*
void remove_character(char *str, char c)
{
  char *dst = str;
  while (*str) {
    if (*str != c) *dst++ = *str;
    str++;
  }
  *dst = '\0';
}
*/

/*
int count_words(char *str)
{
  int count = 0;
  int in_word = 0;
  while (*str) {
    if (isalpha(*str) && !in_word) {
      in_word = 1;
      count++;
    } else if (*str == ' ') {
      in_word = 0;
    }
    str++;
  }
  return count;
}
*/

/*
void reverse_string(char *str)
{
  size_t len = strlen(str);
  for (size_t i = 0; i < len / 2; i++) {
    char temp = str[i];
    str[i] = str[len - i - 1];
    str[len - i - 1] = temp;
  }
}
*/

int main()
{
  return 0;
}

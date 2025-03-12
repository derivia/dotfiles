/* Read lines til EOF
char *line = NULL;
size_t len = 0;
size_t read;
while ((read = getline(&line, &len, stdin)) != -1) { }
*/

/* Read line til '\n'
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

/* Reverse array
void shuffle(int arr[], int n)
{
  for (int i = 0; i < n / 2; i++) {
    int temp = arr[i];
    arr[i] = arr[n - i - 1];
    arr[n - i - 1] = temp;
  }
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

/*
void bubblesort(int arr[], size_t size)
{
  for (int i = 0; i < size - 1; i++) {
    for (int j = 0; j < size - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
}
*/

/* Integer comparison for stdlib qsort
int compare(const void* a, const void* b)
{
  return (*(int*) a - *(int*) b);
}
*/

/*
int factorial(int n)
{
  return (n == 0) ? 1 : n * factorial(n - 1);
}
*/

int main()
{
  return 0;
}

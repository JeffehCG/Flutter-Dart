main(List<String> args) {
  // Armazenando uma função
  int Function(int, int) soma1 = somaFn;
  print(soma1(20, 313));

  // Armazenando uma função anonimas
  int Function(int, int) soma2 = (int x, int y){
    return x + y;
  };
  print(soma2(10, 525));
}

int somaFn(int a, int b){
  return a + b;
}
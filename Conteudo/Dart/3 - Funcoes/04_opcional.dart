import 'dart:math';

main(List<String> args) {
  int n1 = numeroAleatorio(1000);
  print(n1);

  int n2 = numeroAleatorio();
  print(n2);

  imprimirData('/',10, 12, 2020);
  imprimirData('-',10, 12);
  imprimirData('/',10,);
  imprimirData('-');

}

int numeroAleatorio([int maximo = 10]){
  return Random().nextInt(maximo);
}

void imprimirData(String separacao, [int dia =1,int mes = 1, int ano = 1970]){
  print('$dia$separacao$mes$separacao$ano');
}
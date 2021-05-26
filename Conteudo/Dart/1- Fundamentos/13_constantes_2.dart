main(List<String> args) {
  // No exemplo abaixo, uma nova lista não pode ser instanciada, porem os valores internos podem ser alterados
  final listaFinal = ['Ana', 'Lia', 'Gui'];
  listaFinal.add('Rebeca');
  listaFinal[0] = 'Pedro';

  // lista = ['Banana', 'Maça'];
  print(listaFinal);

  // Para que nem os valores internos possam ser alterados, e necessario usar o const
  final listaConst = const ['Ana', 'Lia', 'Gui'];
 
  // listaConst.add("Rebeca");
  print(listaConst);
}
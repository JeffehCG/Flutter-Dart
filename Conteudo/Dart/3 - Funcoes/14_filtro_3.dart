main(List<String> args) {
  var notas = [8.2, 7.1, 6.2, 4.4, 3.9, 8.8, 9.1, 5.1];

  bool Function(double) notasBoasFn = (double nota) => nota >= 7;
  bool Function(double) notasMuitoBoasFn = (double nota) => nota >= 8.8;

  var notasBoas = filtrar<double>(notas, notasBoasFn);
  var notasMuitoBoas = filtrar<double>(notas, notasMuitoBoasFn);

  print(notas);
  print(notasBoas);
  print(notasMuitoBoas);
}

List<E> filtrar<E>(List<E> lista, Function(E) fn){
  List<E> listaFiltrada = [];
  for (var elemento in lista) {
    if(fn(elemento)){
      listaFiltrada.add(elemento);
    }
  }
  return listaFiltrada;
}
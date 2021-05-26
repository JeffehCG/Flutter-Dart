main(List<String> args) {
  var lista1 = [3, 6, 7, 12, 45, 78, 1];
  print(segundoElementoV1(lista1));

  var lista2 = [3, 6, 7, 12, 45, 78, 1];
  print(segundoElementoV2<int>(lista2));
}

Object segundoElementoV1(List lista){
  return lista.length >= 2 ? lista[1] : null;
}

E? segundoElementoV2<E>(List<E> lista){
  return lista.length >= 2 ? lista[1] : null;
}
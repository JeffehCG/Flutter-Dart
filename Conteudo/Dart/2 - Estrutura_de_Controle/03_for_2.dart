main(List<String> args) {
  var notas = [8.9, 9.3, 7.8, 6.9, 9.1];

  for (var nota in notas) {
    print("O valor da nota é $nota");
  }

    var matriz = [
      [8, 9],
      [6, 9],
      [89, 91],
      [7, 69],
      [93, 78]
    ];

  for (var cordenadas in matriz) {
    for (var cordenada in cordenadas) {
     print("O valor da cordenada é $cordenada"); 
    }
  }
}
main(List<String> args) {
  String nome = "João";
  String status = 'aprovado';
  double nota = 9.2;

  // Sem interpolacao
  String frase1 = nome + " esta " + status + " porque tirou nota " + nota.toString() + "!";

  // Com interpolacao
  String frase2 = "$nome esta $status porque tirou nota $nota!";

  print(frase1);
  print(frase2);

  print("O total da compra é R\$ ${3.50 + 4.95}");
}
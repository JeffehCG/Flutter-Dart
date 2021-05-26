import 'package:flutter/material.dart';

// Componente Questão
class Questao extends StatelessWidget {
  final String texto;

  Questao(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10), // Margen de 10 em todos lados
      child: Text(texto,
          style: TextStyle(fontSize: 28), // Aplicando Estilo
          textAlign: TextAlign.center),
    );
  }
}

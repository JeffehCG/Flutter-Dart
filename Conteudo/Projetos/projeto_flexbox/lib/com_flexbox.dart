import 'package:flutter/material.dart';

class ComFlexBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaço entre os itens
      children: <Widget>[
        Container(
          height: 100,
          child: Text('Item 1 - pretty big!'),
          color: Colors.red,
        ),
        Expanded( // Diferente do Flexible, esse componente ja vem com fit: FlexFit.tight (Ocupa o espaço sobrando)
          flex: 4,
          child: Container(
            height: 100,
            child: Text('Item 2'),
            color: Colors.blue,
          ),
        ),
        Flexible(
          flex: 2, // Prioridade, quanto maior for o valor em relação os dos outros componentes, mais espaço esse componente ira ocupar
          fit: FlexFit.loose, // Padrão, ocupa o que esta definido por height e width
          // fit: FlexFit.tight, // Ocupa todo espaço sobrando
          child: Container(
            height: 100,
            child: Text('Item 3'),
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}

// Quando tem o parametro 'flex: 2' o sistema pega todos os elementes que tem esse parametro, soma, e divide o espaço sobrando
// Ou seja, digamos que um elemento tenha o flex: 4 e outro o flex: 2, O sistema ira somar 6, e o segunda elemento ira ocupar 2 do espaço calculado

// Da pra ver no app, que mesmo um elemento estando com FlexFit.tight (Expanded), ainda fica alguns espaços em branco
// Isso acontece por que é respeitado o calculo explicado anterior do parametro flex:, ou seja, ele esta dividino por 4, e os outros 2 estão em branco